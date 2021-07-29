# @codeviking's dotfiles

This repository captures what's required to configure my development
environment.

## Prerequisites

Before getting started, install [brew](https://brew.sh).

## Usage

To setup a new environment:

```bash
git clone git@github.com:codeviking/dotfiles.git
bash install.sh
bash bootstrap.sh
```

Once those steps are done launch a new terminal. You should now see
something like this:

![Screenshot of the configured TTY](tty.png)

There's one more step to get things running. Launch `nvim` and type 
`<leader>tsi` to install the language grammars required for 
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

