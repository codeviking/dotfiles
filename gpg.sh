#!/bin/bash
set -euo pipefail

echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >~/.gnupg/gpg-agent.conf
killall gpg-agent
