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

# gpg
set -x GPG_TTY (tty)

# gcloud kubectl credentials
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.fish.inc" ]
    . "$HOME/opt/google-cloud-sdk/path.fish.inc"
end

# M1
set -x GOARCH arm64
