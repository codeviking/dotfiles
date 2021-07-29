 @codeviking's dotfiles

This repository captures what's required to configure my development
environment.

## Prerequisites

Before getting started, install [brew](https://brew.sh).

## Usage

To setup a new environment:

```bash
git clone git@github.com:codeviking/dotfiles.git

# Install common packages.
bash install.sh

# Initialize user specific config.
bash bootstrap.sh

# Change the default shell to fish.
chsh -s /usr/local/bin/fish
```

Once those steps are done launch a new terminal. You should now see
something like this:

![Screenshot of the configured TTY](tty.png)

There's one more step to get things running. Launch `nvim` and dismiss the
error about a missing theme. Then:

1. Run the `:PackerSync` to install the `nvim` plugins.
1. Type `<leader>tsi` to install the language grammars required for
   [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

That's it. You're all set!

