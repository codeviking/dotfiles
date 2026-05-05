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

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec fish "$dir/install.fish"
