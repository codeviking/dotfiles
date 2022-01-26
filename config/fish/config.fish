#!/bin/fish
#
# System wide fish configuration.
#

set -x LANG en_US.UTF-8

# Use vi style key bindings.
fish_vi_key_bindings

# Use nvim as the default text editor.
set -x EDITOR nvim

# Make sure we're using UTF-8, for good measure.
set -x LANG en_US.UTF-8

# Golang environment
set -x GOPATH "$HOME/go"
fish_add_path "$HOME/go/bin"

# Add the binaries included in this repository to the $PATH
set pdir (realpath (dirname (status --current-filename)))
fish_add_path "$pdir/../../bin"

# Add packages installed via `pip3 install --user $package` to the $PATH.
# TODO: The version we add should be in sync with the version of `python3`.
fish_add_path "$HOME/Library/Python/3.9/bin"

# brew installed curl (which is newer)
fish_add_path /usr/local/opt/curl/bin

# brew sometimes puts things here.
fish_add_path /usr/local/sbin

# gpg
set -x GPG_TTY (tty)

# conda
eval conda "shell.fish" "hook" $argv | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

