#!/bin/bash
#
# Installation steps that should be ran interactively.
#
set -eu

# Set fish as the default shell
chsh -s /usr/local/bin/fish

# See: https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

for src in $dir/config/*; do
    pkg=$(basename "$src")
    target="$HOME/.config/$pkg"
    if [[ ! -f "$target" ]]; then
        ln -s "$src" "$target"
        echo "wrote link $target ~> $src..."
    else
        echo "skipping $HOME/.config/$pkg because it already exists..."
    fi
done

# Install nvim plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c ':PackerSync'

echo "bootstrap complete"
