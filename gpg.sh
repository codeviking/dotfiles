#!/bin/bash
set -euo pipefail

gpg-connect-agent killagent /bye

mkdir -p ~/.gnupg
touch ~/.gnupg/gpg.conf ~/.gnupg/gpg-agent.conf

cat > ~/.gnupg/gpg-agent.conf <<EOF
  pinentry-program $(brew --prefix)/bin/pinentry-mac
  enable-ssh-support
  use-standard-socket
EOF

echo "use-agent" > ~/.gnupg/gpg.conf
