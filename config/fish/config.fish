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

# Set GPG TTY
set -gx GPG_TTY (tty)

# Update the GPG_TTY whenever a command is executed so that it's kept in sync
function update_gpg_tty --on-event fish_preexec
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end

# Launch gpg-agent and set the SSH_AUTH_SOCK
gpgconf --launch gpg-agent

# Ensure that GPG Agent is used as the SSH agent
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Default go builds to arm64
set -gx GOARCH arm64
set -gx GOOS darwin

# Add SSH key to SSH agent
ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519" 2>/dev/null

# Disable default venv prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# Disable greeting
set fish_greeting

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$(brew --prefix)/google-cloud-sdk/path.fish.inc" ]
    source "$(brew --prefix)/google-cloud-sdk/path.fish.inc"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# fix remote terminal when using ghostty
set --export TERM xterm-256color

# add local binaries to the path
fish_add_path $HOME/.local/bin

# secrets that are exported in all shells
if [ -f "$HOME/.secret/fish/shell.fish" ]
    source "$HOME/.secret/fish/shell.fish"
end

# this disables the user@host prompt, which isn't very helpful
set -g DEFAULT_USER $(whoami)

# set XDG_CONFIG_HOME; for my purposes this is for loading k9s settings
set -gx XDG_CONFIG_HOME $HOME/.config
