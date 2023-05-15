#!/bin/bash
# Install dependencies for running scripts like install.sh and link.sh
set -euo pipefail

brew install go@1.19
brew install node
brew install coreutils
