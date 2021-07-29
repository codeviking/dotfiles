#!/bin/fish
#
# System wide fish configuration.
#

# Use vi style key bindings.
fish_vi_key_bindings

# Use nvim as the default text editor.
set -x EDITOR nvim

# Make sure we're using UTF-8, for good measure.
set -x LANG en_US.UTF-8

# PATH munging
set -x GOPATH $HOME/go
set -x PATH $PATH:$HOME/go/bin

# gpg
set -x GPG_TTY (tty)
