#!/usr/bin/env bash
#
# Local development server for the `update` branch.
# Run this, edit files, and the browser auto-refreshes — so you can iterate
# fast and confirm changes locally BEFORE merging to main (which goes live at
# https://jingweio.github.io/).
#
#   Usage:  ./serve-local.sh            # serve at http://localhost:4000
#           ./serve-local.sh --port 4001
#
# Stop the server with Ctrl-C.

set -euo pipefail

# Always run from the repo root (the dir this script lives in).
cd "$(dirname "${BASH_SOURCE[0]}")"

# On Apple Silicon, point pkg-config at Homebrew's libffi so any native gem
# that needs to build can find a working libffi (the gem's vendored one fails
# to configure under modern clang).
if command -v brew >/dev/null 2>&1; then
  _libffi="$(brew --prefix libffi 2>/dev/null || true)"
  if [ -n "${_libffi}" ]; then
    export PKG_CONFIG_PATH="${_libffi}/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
  fi
fi

# Keep gems isolated inside the project (vendor/ is git-ignored).
bundle config set --local path 'vendor/bundle' >/dev/null

# Install gems on first run (and after Gemfile changes); fast no-op otherwise.
if ! bundle check >/dev/null 2>&1; then
  echo ">> Installing Ruby gems (first run only)…"
  bundle install
fi

echo ">> Starting Jekyll at http://localhost:4000  (Ctrl-C to stop)"
echo ">> Live-reload is on: save a file and the browser refreshes automatically."

# --livereload : auto-refresh the browser on file save
# --config     : layer local dev overrides on top of the production config
# --open-url   : open the site in the default browser
# Jekyll already defaults to host 127.0.0.1 and port 4000; extra CLI args
# (e.g. --port 4001, --incremental) are passed straight through to override.
exec bundle exec jekyll serve \
  --livereload \
  --config _config.yml,_config.dev.yml \
  --open-url \
  "$@"
