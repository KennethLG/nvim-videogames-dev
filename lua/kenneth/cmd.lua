vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
  pattern = "*",
  callback = function()
    vim.cmd('silent! mkview')  -- Save view (cursor position, folds, etc.)
  end
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*",
  callback = function()
    vim.cmd('silent! loadview') -- Restore view
  end
})
