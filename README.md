# @codeviking's dotfiles

This repository captures what's required to configure my development
environment.

## Prerequisites

Before getting started, install [brew](https://brew.sh).

## Usage

To setup a new environment:

```bash
git clone git@github.com:codeviking/dotfiles.git

# Install minimum dependencies.
./bootstrap.sh

# Install common packages.
./install.sh

# Link configuration files into expectated locations.
./link.sh

# Initialize GPG
bash gpg.sh

# Add fish as a possible shell by editing `/etc/shells`:
# + /opt/homebrew/bin/fish
sudo vim /etc/shells

# Change the default shell to fish.
chsh -s /usr/local/bin/fish
```

Once those steps are done launch a new terminal. You should now see
something like this:

![Screenshot of the configured TTY](tty.png)

There's one more step to get things running. Launch `nvim` and dismiss the
error about a missing theme. Then run `:PackerSync` to install the configured
list of `nvim` plugins (which includes the theme).

That's it. You're all set!

## Advanced

### Host Specific PATH Extensions

As much as we'd like to avoid it, host-specific `$PATH` extensions are at 
times warranted.

To set host specific `$PATH` extensions create a file at the path
`$HOME/.config/paths.fish` that looks something like this:

```fish
#!/bin/fish

# gcloud
source "$HOME/lib/google-cloud-sdk/paths.fish.inc"

set -x "$PATH:$HOME/bin"
```

The commands above are examples, populate the file with the `$PATH` specific 
changes that make sense for the host you're on.

