#!/opt/homebrew/bin/fish
#
# Fish specific installation steps that must occur after fish has been installed,
# which is part of install.sh
#

# Install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install tide theme
# https://github.com/IlanCosman/tide
fisher install IlanCosman/tide@v6

# Configure tide
tide configure \
    --auto \
    --style=Rainbow \
    --prompt_colors='True color' \
    --show_time='24-hour format' \
    --rainbow_prompt_separators=Angled \
    --powerline_prompt_heads=Sharp \
    --powerline_prompt_tails=Flat \
    --powerline_prompt_style='One line' \
    --prompt_spacing=Compact \
    --icons='Few icons' \
    --transient=No

# Modify right prompt items
set --universal tide_right_prompt_items \
    status \
    cmd_duration \
    context jobs \
    direnv \
    node \
    python \
    go \
    time \
    kubectl

echo "OK: fish specific installation steps complete"
