#!/bin/fish
#
# Configuration for the fzf command, a fuzzy finder:
# https://github.com/junegunn/fzf
#

set -x FZF_DEFAULT_COMMAND 'rg --files'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
