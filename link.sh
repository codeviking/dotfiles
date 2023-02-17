#!/bin/bash
# Installation steps that should be ran interactively.
set -euo pipefail

# See: https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Symlink ~/.config/$dir all dirs in config
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

# Symlink things that don't live in ~/.config
ln -s $dir/tmux/tmux.conf ~/.tmux.conf

# Install oh-my-fish; this must be done after linking things above.
curl -L https://get.oh-my.fish > /tmp/install.fish
echo "429a76e5b5e692c921aa03456a41258b614374426f959535167222a28b676201  /tmp/install.fish" \
    | sha256sum --check
fish /tmp/install.fish -y --noninteractive

# Install the pure theme.
fish -c "omf install pure"

# Initialize conda (silly conda) and prevent base environment from being active by default.
conda init fish
conda config --set auto_activate_base false

echo "link complete"
