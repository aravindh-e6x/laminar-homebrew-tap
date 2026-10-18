# Laminar downloads and Homebrew tap

Install the Laminar unified engine on Apple Silicon with macOS 14 or later.
The package includes the console, a private Python runtime, notebook packages,
and the ICU time-zone extension.

## Install with curl

```sh
curl -fsSL https://github.com/e6data/laminar-releases/releases/latest/download/install.sh | bash
export PATH="$HOME/.local/bin:$PATH"
laminar
```

Add the PATH line to your shell profile for new terminals. The installer uses
the complete release package, verifies its SHA-256 checksum, and installs into
`~/.local/share/laminar`. It does not need Homebrew or administrator access.
The command is linked at `~/.local/bin/laminar`.

Run the same installer again to update. To choose a version, append
`| bash -s -- --version 0.1.2` in place of `| bash`.

## Install with Homebrew

```sh
brew tap aravindh-e6x/laminar https://github.com/aravindh-e6x/laminar-homebrew-tap.git
brew install aravindh-e6x/laminar/laminar
laminar
```

Open <http://127.0.0.1:15003/> after starting Laminar.

Configuration and data are stored in `~/Library/Application Support/Laminar`.
Set `LAMINAR_HOME` before starting Laminar to use another directory.

## Update

```sh
brew update
brew upgrade aravindh-e6x/laminar/laminar
```

This tap now uses the current unified package. Its version sequence starts
below the old tap's `0.1.26`. The formula has `version_scheme 1` so Homebrew
can upgrade existing installs to the current package.

The old `laminar-demo` formula has been removed. The `laminar` package includes
the console and notebook runtime. If the old demo is installed, remove it with
`brew uninstall laminar-demo`, then install `aravindh-e6x/laminar/laminar`.

## Switch from the organization tap

Keep only one Laminar tap. Homebrew can fail while fixing library links when
both `e6data/tap` and this tap define `laminar`, even with a fully qualified
install command.

After adding this tap, switch an existing organization-tap install with:

```sh
brew trust --formula e6data/tap/laminar
brew uninstall e6data/tap/laminar
brew untap e6data/tap
brew install aravindh-e6x/laminar/laminar
```

Skip the uninstall command if the organization tap's package is not installed.
Application data in `~/Library/Application Support/Laminar` stays in place.

## Releases

The formula downloads versioned archives from
[Laminar releases](https://github.com/e6data/laminar-releases/releases).
Each archive has a fixed SHA-256 checksum. Source code and build workflows
remain in the main development repository.

The release publisher updates this tap directly with its GitHub login. Formula updates
do not require a pull request approval. Old Git history and release assets
remain available.
