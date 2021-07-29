# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.local/share/omf"

# Point the Oh My Fish config at a location that we explicitly provide
# in the image, so it's portable.
set -gx OMF_CONFIG "$HOME/.config/omf"

# Load Oh My Fish configuration.
source "$OMF_PATH/init.fish"
