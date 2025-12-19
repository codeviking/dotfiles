#!/opt/homebrew/bin/fish
#
# Fish specific installation steps that must occur after fish has been installed,
# which is part of install.sh
#

# Install tide theme
# https://github.com/IlanCosman/tide
fisher install IlanCosman/tide@v6

# Configure tide
tide configure \
    --auto \
    --style=Slanted \
    --prompt_colors='True color' \
    --show_time='24-hour format' \
    --rainbow_prompt_separators=Angled \
    --powerline_prompt_heads=Sharp \
    --powerline_prompt_tails=Flat \
    --powerline_prompt_style='One line' \
    --prompt_spacing=Compact \
    --icons='Few icons' \
    --transient=No

echo "OK: fish specific installation steps complete"
