vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.api.nvim_create_user_command('Markdownlint', '!markdownlint %', {})
  end,
})
