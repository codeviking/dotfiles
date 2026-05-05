#!/bin/bash
set -euo pipefail

# Make fish the default login shell. Run after ./install.sh.
# Skip in environments where you don't own the workspace template (e.g. Coder)
# — install.sh already wires up bash to hand off to fish for interactive
# sessions, which is enough in those cases.

fish_path="$(brew --prefix)/bin/fish"

if [[ ! -x "$fish_path" ]]; then
  echo "Error: fish not found at $fish_path. Run ./install.sh first."
  exit 1
fi

# Add fish to /etc/shells if it's not already there.
if ! grep -qxF "$fish_path" /etc/shells; then
  echo "Adding $fish_path to /etc/shells (requires sudo)..."
  echo "$fish_path" | sudo tee -a /etc/shells > /dev/null
fi

# Change the default login shell to fish.
chsh -s "$fish_path"

echo "OK: fish is now the default shell. Open a new terminal to use it."
