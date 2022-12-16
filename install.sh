#!/bin/bash
# Install some required software using brew.
set -euo pipefail

# If we're on MacOS use brew to install a bunch of packages.
if [[ "$(uname)" == "Darwin" ]]; then
    if !command -v brew &> /dev/null; then
        echo "Error: brew isn't installed."
        exit 1
    fi

    pkgs=(
        "nvim"
        "jq"
        "yq"
        "python@3.11"
        "go@1.19"
        "node@18"
        "fish"
        "fzf"
        "kubectl"
        "ripgrep"
        "mosh"
        "blueutil"
        "shellcheck"
        "curl"
    )
    for pkg in "${pkgs[@]}"; do
        brew install "$pkg"
    done

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
echo "bb1f4025934600ea6feef2ec11660e17e2b6449c5a23c033860aed712ad328c9  /tmp/install.fish" \
    | sha256sum --check
fish /tmp/install.fish -y --noninteractive

# Install the pure theme.
fish -c "omf install pure"

echo "install complete"
