#!/bin/bash
set -euo pipefail

# General installation and setup.

# If we're on MacOS use brew to install a bunch of packages.
if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo "Error: brew isn't installed."
    exit 1
  fi

  brew install \
    nvim \
    jq \
    yq \
    python \
    go \
    node \
    corepack \
    coreutils \
    fish \
    fzf \
    kubectl \
    ripgrep \
    mosh \
    blueutil \
    shellcheck \
    curl \
    wget \
    cmctl \
    jsonnet \
    libpq \
    awscli \
    tree \
    pstree \
    gh \
    gpg \
    pinentry-mac \
    grpcurl \
    gsed \
    uv

  brew install --casks font-meslo-for-powerline \
    1password/tap/1password-cli \
    ghostty \
    rectangle \
    docker-desktop

  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform

  "$(brew --prefix)"/opt/fzf/install --all
else
  # TODO: Add equivalent commands for other operating systems
  echo "Warning: The host os isn't MacOS, some packages won't be installed"
fi

# Language server installation
# See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

go install golang.org/x/tools/gopls@latest

npm install -g pyright \
  typescript \
  typescript-language-server \
  bash-language-server \
  vscode-langservers-extracted \
  dockerfile-language-server-nodejs \
  @anthropic-ai/claude-code

# Install fisher
# https://github.com/jorgebucaran/fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Enable corepack (and thereby yarn)
corepack enable

echo "OK: install complete"
