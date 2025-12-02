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

# Add a brew binaries to the PATH
fish_add_path "$(brew --prefix)/bin"

# Add version agnostic python links
fish_add_path $(brew --prefix python)/libexec/bin

# Add psql binaries (which are keg only) to PATH
fish_add_path "$(brew --prefix)/opt/libpq/bin"
fish_add_path "$(brew --prefix)/sbin"

# Override MacOS python3 installation
mkdir -p "$HOME/bin"
if [ ! -L "$HOME/bin/python3" ]
    ln -s "$(brew --prefix)/bin/python3.11" "$HOME/bin/python3"
end
if [ ! -L "$HOME/bin/python" ]
    ln -s "$(brew --prefix)/bin/python3.11" "$HOME/bin/python"
end

# gpg
set -x GPG_TTY (tty)

# gcloud kubectl credentials
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.fish.inc" ]
    source "$HOME/opt/google-cloud-sdk/path.fish.inc"
end

# M1
set -x GOARCH arm64

# Add SSH key to SSH agent
ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519" 2>/dev/null

# Disable default venv prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# Disable greeting
set fish_greeting

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sams/opt/google-cloud-sdk/path.fish.inc' ]
    source '/Users/sams/opt/google-cloud-sdk/path.fish.inc'
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# fix remote terminal when using ghostty
set --export TERM xterm-256color

# add `uv` binaries to the path
fish_add_path /Users/sams/.local/bin

# secrets that are exported in all shells
if [ -f "$HOME/.secret/fish/shell.fish" ]
    source "$HOME/.secret/fish/shell.fish"
end

# This disables the user@host prompt, which isn't very helpful
set -g DEFAULT_USER $(whoami)
