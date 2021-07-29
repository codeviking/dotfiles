#!/bin/bash
#
# Installation steps that should be ran interactively.
#
set -eu

# See: https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

for src in $dir/config/*; do
    pkg=$(basename "$src")
    target="$HOME/.config/$pkg"

    # If it's not a symlink...
    if [[ ! -L "$target" ]]; then

        # ...and it's a file or directory back it up first
        if [[ -f "$target" ]] || [[ -d "$target" ]]; then
            echo "making a backup of $target..."
            backup=$HOME/.config/$pkg-dotfiles-backup-$(date +%s)
            mv "$target" "$backup"
            echo "backed up $target to $backup..."
        fi

        ln -s "$src" "$target"
        echo "wrote link $target ~> $src..."
    else
        echo "$target already exists and is a symlink, skipping..."
    fi
done

echo "bootstrap complete"
