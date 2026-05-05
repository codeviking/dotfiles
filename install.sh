#!/bin/bash
set -euo pipefail

# Bootstrap fish, then hand off to install.fish for the rest of the install.

if ! command -v brew &>/dev/null; then
  echo "Error: brew isn't installed. Install Homebrew/Linuxbrew first: https://brew.sh"
  exit 1
fi

if ! command -v fish &>/dev/null; then
  echo "Installing fish..."
  brew install fish
fi

# Make sure brew's bin/sbin are on PATH for the fish process below — otherwise
# go/npm/corepack (installed by install.fish) won't be found in this session.
eval "$(brew shellenv)"

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec fish "$dir/install.fish"
