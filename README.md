# Laminar Homebrew tap

Install the Laminar unified engine on Apple Silicon with macOS 14 or later.
The package includes the console, a private Python runtime, notebook packages,
and the ICU time-zone extension.

## Install

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

If Laminar was installed from `e6data/tap`, add this tap and run:

```sh
brew reinstall aravindh-e6x/laminar/laminar
```

## Releases

The formula downloads versioned archives from
[Laminar releases](https://github.com/e6data/laminar-releases/releases).
Each archive has a fixed SHA-256 checksum. Source code and build workflows
remain in the main development repository.

The release publisher updates this tap directly through SSH. Formula updates
do not require a pull request approval. Old Git history and release assets
remain available.
