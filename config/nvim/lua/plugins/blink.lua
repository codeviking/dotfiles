return {
  "saghen/blink.cmp",
  opts = {
    enabled = function()
      -- Get current node
      local success, node = pcall(vim.treesitter.get_node)
      if not success or not node then return true end

      -- List of comment-related node types to ignore
      local comment_nodes = { "comment", "comment_content", "line_comment", "block_comment" }

      -- Check if current node is a comment
      if vim.tbl_contains(comment_nodes, node:type()) then
        return false
      end

      -- Edge case: Check the character immediately before the cursor (catches the end of comments)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if col > 0 then
        local prev_node = vim.treesitter.get_node({ pos = { vim.api.nvim_win_get_cursor(0)[1] - 1, col - 1 } })
        if prev_node and vim.tbl_contains(comment_nodes, prev_node:type()) then
          return false
        end
      end

      return true
    end,
  },
}
