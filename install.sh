#!/bin/sh
#
# Install some required software using brew.
#
set -eu

#
# If we're on MacOS use brew to install a bunch of packages.
#
if [[ "$(uname)" == "Darwin" ]]; then
    if !command -v brew &> /dev/null; then
        echo "Error: brew isn't installed."
        exit 1
    fi

    pkgs=(
        "nvim"
        "jq"
        "python@3.9"
        "go@1.16"
        "fish"
        "node@16"
        "kubectl"
        "fzf"
        "ripgrep"
        "mosh"
    )
    for pkg in "${pkgs[@]}"; do
        brew install "$pkg"
    done

    $(brew --prefix)/opt/fzf/install
else
    # TODO: Add equivalent commands for other operating systems
    echo "Warning: The host os isn't MacOS, some packages won't be installed"
fi

#
# We install a bunch of language servers, which are used by nvim for syntax
# highlighting, refactoring and more.
#

# golang
go install golang.org/x/tools/gopls@latest

# sql
go install github.com/lighttiger2505/sqls@latest

# python
npm install -g pyright

# TypeScript
npm install -g typescript
npm install -g typescript-language-server

# bash
npm install -g bash-language-server

# html, css and json
npm install -g vscode-langservers-extracted

# docker
npm install -g dockerfile-language-server-nodejs

#
# These packages allow nvim plugins to use python3 and nodejs.
# I deliberately don't install the same lib for python2, to avoid coupling
# myself as much as possible to python2.
#
npm install -g neovim
python3 -m pip install --user pynvim

#
# Install oh-my-fish
#
curl -L https://get.oh-my.fish > /tmp/install.fish
echo "bb1f4025934600ea6feef2ec11660e17e2b6449c5a23c033860aed712ad328c9  /tmp/install.fish" \
    | sha256sum --check
fish /tmp/install.fish -y --noninteractive

# Install the pure theme.
fish -c "omf install pure"

#
# Global pip utilities
#
pip3 install --user yq

echo "install complete"
