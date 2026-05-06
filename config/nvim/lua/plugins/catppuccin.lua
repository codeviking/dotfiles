return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      background = { light = "latte", dark = "mocha" },
      integrations = {
        blink_cmp = true,
        mason = true,
        native_lsp = { enabled = true },
        noice = true,
        notify = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin" },
  },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 999,
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd.colorscheme("catppuccin")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
}
