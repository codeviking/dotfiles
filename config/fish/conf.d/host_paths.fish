#!/bin/fish
#
# This script adds support for host-specific path overrides, which are
# inevitably at times necessary.
#

set -x host_paths "$HOME/.config/paths.fish"
if test -f "$host_paths"
    source "$host_paths"
end

