#!/usr/bin/env fish
#
# End-to-end dotfiles install. Invoked by install.sh after fish is bootstrapped.
#

set -l os (uname)
set -l dir (realpath (dirname (status --current-filename)))

# --- 1. Brew packages ---

brew install \
    nvim \
    jq \
    yq \
    python \
    go \
    node \
    corepack \
    coreutils \
    fish \
    fzf \
    kubectl \
    ripgrep \
    mosh \
    shellcheck \
    curl \
    wget \
    cmctl \
    jsonnet \
    libpq \
    awscli \
    tree \
    pstree \
    gh \
    gpg \
    grpcurl \
    gsed \
    uv \
    ffmpeg \
    k9s \
    kubie \
    watch \
    withgraphite/tap/graphite \
    fd \
    oci-cli \
    depot/tap/depot \
    helm

if test "$os" = Darwin
    brew install pinentry-mac blueutil

    brew install --casks font-meslo-for-powerline \
        1password/tap/1password-cli \
        ghostty \
        rectangle \
        docker-desktop \
        gcloud-cli
else
    # Linuxbrew has no casks; install only the formulae available there.
    brew install pinentry
end

brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# --- 2. Link configuration files into ~/.config and friends ---

mkdir -p $HOME/.config

for src in $dir/config/*
    set -l pkg (basename $src)
    set -l target $HOME/.config/$pkg

    if not test -L $target
        if test -f $target -o -d $target
            set -l backup $HOME/.config/$pkg-dotfiles-backup-(date +%s)
            echo "making a backup of $target..."
            mv $target $backup
            echo "backed up $target to $backup..."
        end
        ln -s $src $target
        echo "wrote link $target ~> $src..."
    else
        echo "$target already exists and is a symlink, skipping..."
    end
end

if not test -L $HOME/.tmux.conf
    ln -s $dir/tmux/tmux.conf $HOME/.tmux.conf
end

if not test -L $HOME/.kube/kubie.yaml
    mkdir -p $HOME/.kube
    ln -s $dir/kubie/kubie.yaml $HOME/.kube/kubie.yaml
end

# Silence iTerm login message (mac only, harmless on Linux).
touch $HOME/.hushlogin

# --- 3. Git config ---

git config --global user.name "Sam Skjonsberg"
git config --global user.email "sam@runwayml.com"
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra
git config --global core.excludesfile "~/.gitignore"

if not test -f $HOME/.gitignore
    touch $HOME/.gitignore
end
if not grep -qxF .DS_Store $HOME/.gitignore
    echo .DS_Store >> $HOME/.gitignore
end

# --- 4. Make interactive bash drop into fish ---
# For environments where we don't own the workspace template and can't chsh
# (e.g. Coder), this hands any interactive bash session off to fish.

set -l bashrc $HOME/.bashrc
set -l begin_marker "# dotfiles:fish-handoff:begin"
set -l end_marker "# dotfiles:fish-handoff:end"

# Strip any prior block (legacy single-marker form or current begin/end form)
# so we can re-write the snippet idempotently across versions.
if test -f $bashrc
    if grep -qF "$begin_marker" $bashrc
        sed -i.bak "/$begin_marker/,/$end_marker/d" $bashrc
        rm -f $bashrc.bak
    end
    if grep -qF "# dotfiles: hand off to fish for interactive bash sessions" $bashrc
        sed -i.bak "/# dotfiles: hand off to fish for interactive bash sessions/,/^fi\$/d" $bashrc
        rm -f $bashrc.bak
    end
end

printf '\n%s\nif [ -z "$FISH_VERSION" ] && [ -t 1 ]; then\n  for fish_bin in /home/linuxbrew/.linuxbrew/bin/fish /opt/homebrew/bin/fish "$(command -v fish 2>/dev/null)"; do\n    [ -x "$fish_bin" ] && exec "$fish_bin"\n  done\nfi\n%s\n' "$begin_marker" "$end_marker" >> $bashrc

# --- 5. Fisher + tide ---

if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end

function _fisher_install_if_missing
    set -l plugin $argv[1]
    set -l key (string split -m1 '@' $plugin)[1]
    if fisher list 2>/dev/null | grep -i -q -x -F -- $key
        echo "fisher: $plugin already installed, skipping"
    else
        fisher install $plugin
    end
end

_fisher_install_if_missing IlanCosman/tide@v6
_fisher_install_if_missing dracula/fish
_fisher_install_if_missing catppuccin/fish

tide configure --auto --style=Lean --prompt_colors='True color' \
    --show_time=No --lean_prompt_height='Two lines' \
    --prompt_connection=Disconnected --prompt_spacing=Compact \
    --icons='Few icons' --transient=No

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

# --- 6. Language servers ---

go install golang.org/x/tools/gopls@latest

npm install -g pyright \
    typescript \
    typescript-language-server \
    bash-language-server \
    vscode-langservers-extracted \
    dockerfile-language-server-nodejs

# --- 7. Claude Code ---

curl -fsSL https://claude.ai/install.sh | bash

# --- 8. corepack (yarn) ---

corepack enable

# --- 9. Rust toolchain (non-interactive) ---

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# --- 10. tree-sitter CLI (Linux only) ---
# Build via cargo against system glibc — Linuxbrew's tree-sitter is linked
# against a newer glibc than Ubuntu 22.04 ships, which breaks nvim-treesitter.
# On macOS the brew build is fine.

if test "$os" != Darwin
    $HOME/.cargo/bin/cargo install tree-sitter-cli
end

echo "OK: install complete"
