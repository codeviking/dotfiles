return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      -- Show todo comments in the sign column but don't highlight the text
      highlight = {
        keyword = "",
        after = "",
      },
    },
  },
}
