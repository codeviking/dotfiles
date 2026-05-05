#!/bin/bash
set -euo pipefail

gpg-connect-agent killagent /bye

mkdir -p ~/.gnupg
touch ~/.gnupg/gpg.conf ~/.gnupg/gpg-agent.conf

if [[ "$(uname)" == "Darwin" ]]; then
  pinentry_program="$(brew --prefix)/bin/pinentry-mac"
else
  pinentry_program="$(brew --prefix)/bin/pinentry"
fi

cat > ~/.gnupg/gpg-agent.conf <<EOF
  pinentry-program $pinentry_program
  enable-ssh-support
  use-standard-socket
EOF

cat > ~/.gnupg/gpg.conf << EOF
  use-agent
  batch
EOF
