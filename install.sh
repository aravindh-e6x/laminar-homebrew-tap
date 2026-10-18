#!/usr/bin/env bash
set -euo pipefail

release_root=https://github.com/e6data/laminar-releases/releases
requested_version=
install_root="${LAMINAR_INSTALL_DIR:-${HOME:?HOME must be set}/.local/share/laminar}"
bin_dir="${LAMINAR_BIN_DIR:-$HOME/.local/bin}"
work_dir=
lock_dir=

fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
cleanup() {
  if [ -n "$work_dir" ]; then rm -rf "$work_dir"; fi
  if [ -n "$lock_dir" ]; then rmdir "$lock_dir" 2>/dev/null || true; fi
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

usage() {
  cat <<'HELP'
Install Laminar for Apple Silicon, macOS 14 or later.

Usage: bash install.sh [--version VERSION] [--install-dir PATH] [--bin-dir PATH]

With no version, install the latest stable release. Run again to update.
Default package directory: ~/.local/share/laminar
Default command directory: ~/.local/bin
Configuration and data: ~/Library/Application Support/Laminar
HELP
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --version|--install-dir|--bin-dir)
      [ "$#" -ge 2 ] || fail "$1 needs a value."
      case "$1" in
        --version) requested_version="${2#v}" ;;
        --install-dir) install_root="$2" ;;
        --bin-dir) bin_dir="$2" ;;
      esac
      shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) fail "Unknown option: $1. Use --help." ;;
  esac
done

version_pattern='^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z]+([.-][0-9A-Za-z]+)*)?$'
if [ -n "$requested_version" ]; then
  [[ "$requested_version" =~ $version_pattern ]] || fail 'Use a version such as 0.1.2.'
fi
[ "$(uname -s)" = Darwin ] || fail 'This installer supports macOS only.'
[ "$(uname -m)" = arm64 ] || fail 'Use an Apple Silicon Mac and a native ARM64 terminal.'
os_version=$(sw_vers -productVersion)
os_major="${os_version%%.*}"
[[ "$os_major" =~ ^[0-9]+$ ]] && [ "$os_major" -ge 14 ] || fail 'macOS 14 or later is required.'
case "$install_root" in /*) ;; *) fail '--install-dir must be an absolute path.' ;; esac
case "$bin_dir" in /*) ;; *) fail '--bin-dir must be an absolute path.' ;; esac
for tool in curl shasum ditto unzip awk mktemp; do
  command -v "$tool" >/dev/null || fail "Required macOS tool is missing: $tool"
done

command_path="$bin_dir/laminar"
if [ -e "$command_path" ] || [ -L "$command_path" ]; then
  [ -L "$command_path" ] && [ "$(readlink "$command_path")" = "$install_root/current/bin/laminar" ] \
    || fail "$command_path already exists. Choose another --bin-dir or move that file first."
fi
if [ -e "$install_root/current" ] && [ ! -L "$install_root/current" ]; then
  fail "$install_root/current is not an installer-managed symlink."
fi
mkdir -p "$install_root/versions" "$bin_dir"
if ! mkdir "$install_root/.install.lock" 2>/dev/null; then
  fail "Another install may be running. Check $install_root/.install.lock."
fi
lock_dir="$install_root/.install.lock"
work_dir=$(mktemp -d "$install_root/.install.XXXXXX")

fetch() {
  curl --fail --location --show-error --progress-bar --proto '=https' --tlsv1.2 \
    --connect-timeout 20 --max-time 600 --retry 2 "$1" --output "$2"
}

if [ -n "$requested_version" ]; then
  checksum_url="$release_root/download/v$requested_version/SHA256SUMS"
else
  checksum_url="$release_root/latest/download/SHA256SUMS"
fi
printf 'Finding Laminar release…\n'
fetch "$checksum_url" "$work_dir/SHA256SUMS"
[ "$(awk 'NF {n++} END {print n+0}' "$work_dir/SHA256SUMS")" -eq 1 ] \
  || fail 'Expected one Apple Silicon archive in SHA256SUMS.'
read -r checksum archive < "$work_dir/SHA256SUMS"
[[ "$checksum" =~ ^[0-9a-f]{64}$ ]] || fail 'Invalid release checksum.'
archive_pattern='^laminar-([0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z]+([.-][0-9A-Za-z]+)*)?)-darwin-arm64\.zip$'
[[ "$archive" =~ $archive_pattern ]] || fail 'Invalid release archive name.'
version="${BASH_REMATCH[1]}"
if [ -n "$requested_version" ]; then
  [ "$version" = "$requested_version" ] || fail 'The release version does not match its checksum file.'
fi
destination="$install_root/versions/$version"

if [ -e "$destination" ]; then
  [ -d "$destination" ] && [ -f "$destination/.archive-sha256" ] \
    && [ "$(cat "$destination/.archive-sha256")" = "$checksum" ] \
    || fail "$destination already exists with different contents."
else
  printf 'Downloading Laminar %s…\n' "$version"
  # Pin the archive to the version found above, even if latest changes meanwhile.
  fetch "$release_root/download/v$version/$archive" "$work_dir/$archive"
  (cd "$work_dir" && shasum -a 256 -c SHA256SUMS)
  unzip -Z1 "$work_dir/$archive" | awk '
    !/^laminar\// || /(^|\/)\.\.(\/|$)/ || /\\/ {bad=1}
    END {exit bad}
  ' || fail 'The archive contains an unexpected path.'
  ditto -x -k "$work_dir/$archive" "$work_dir/extracted"
  bundle="$work_dir/extracted/laminar"
  manifest="$bundle/share/laminar/release.json"
  [ -f "$manifest" ] && [ -x "$bundle/bin/laminar" ] \
    && [ -x "$bundle/runtime/python/bin/python3" ] \
    && [ -f "$bundle/lib/duckdb/icu.duckdb_extension" ] \
    || fail 'The archive is missing required package files.'
  manifest_version=$(awk -F '"' '/^[[:space:]]*"version"[[:space:]]*:/ {print $4; exit}' "$manifest")
  [ "$manifest_version" = "$version" ] || fail 'The package manifest has a different version.'
  [ "$("$bundle/bin/laminar" --version)" = "laminar $version (aarch64-apple-darwin)" ] \
    || fail 'The packaged command did not report the expected version.'
  printf '%s\n' "$checksum" > "$bundle/.archive-sha256"
  mv "$bundle" "$destination"
fi

[ -x "$destination/bin/laminar" ] || fail 'The installed version is missing its executable.'
# Stage both links beside their destinations. BSD mv -h replaces the link itself.
ln -s "versions/$version" "$work_dir/current"
mv -f -h "$work_dir/current" "$install_root/current"
link_path="$bin_dir/.laminar-link-$$"
ln -s "$install_root/current/bin/laminar" "$link_path"
mv -f -h "$link_path" "$command_path"
printf '\nInstalled Laminar %s at %s\n' "$version" "$command_path"
if [ "$(command -v laminar || true)" != "$command_path" ]; then
  printf '\nUse this PATH in your terminal and shell profile:\n'
  printf '  export PATH=%q:"$PATH"\n' "$bin_dir"
fi
printf '\nRun: %s\nThen open http://127.0.0.1:15003/\n' "$command_path"
