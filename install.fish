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
fisher install dracula/fish
fisher install catppuccin/fish

# Configure tide
tide configure --auto --style=Lean --prompt_colors='True color' \
  --show_time=No --lean_prompt_height='Two lines' \
  --prompt_connection=Disconnected --prompt_spacing=Compact \
  --icons='Few icons' --transient=No

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
