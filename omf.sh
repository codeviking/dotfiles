#!/bin/bash
set -euo pipefail

# Install oh-my-fish; this must be done after running link.sh
curl -L https://get.oh-my.fish > /tmp/install.fish
echo "429a76e5b5e692c921aa03456a41258b614374426f959535167222a28b676201  /tmp/install.fish" \
    | sha256sum --check
fish /tmp/install.fish -y --noninteractive

# Install theme.
fish -c "omf install agnoster"

echo "omf complete"
