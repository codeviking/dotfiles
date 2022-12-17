#!/bin/bash
set -euo pipefail

brew install gpg
brew install pinentry-mac
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
killall gpg-agent

