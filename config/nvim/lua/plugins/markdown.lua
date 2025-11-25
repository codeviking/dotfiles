-- Don't conceal links in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ""
  end,
})

-- Disable rich markdown rendering
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
}
