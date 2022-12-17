#!/bin/bash
# Install some required software using brew.
set -euo pipefail

# If we're on MacOS use brew to install a bunch of packages.
if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Error: brew isn't installed."
        exit 1
    fi

    brew install \
        nvim \
        jq \
        yq \
        python@3.11 \
        go@1.19 \
        node \
        fish \
        fzf \
        kubectl \
        ripgrep \
        mosh \
        blueutil \
        shellcheck \
        curl \
        wget
    $(brew --prefix)/opt/fzf/install
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
               dockerfile-language-server-nodejs

# Install oh-my-fish
curl -L https://get.oh-my.fish > /tmp/install.fish
echo "429a76e5b5e692c921aa03456a41258b614374426f959535167222a28b676201  /tmp/install.fish" \
    | sha256sum --check
fish /tmp/install.fish -y --noninteractive



echo "install complete"
