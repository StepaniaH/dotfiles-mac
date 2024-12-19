local opt = vim.opt
opt.termguicolors = true
opt.ttyfast = true
opt.cursorline = true
opt.wrap = true
opt.number = true
opt.relativenumber = true
opt.autochdir = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.showmode = false
opt.mouse = 'a'
opt.showtabline = 2
opt.laststatus = 2
opt.cmdheight = 1
opt.clipboard = 'unnamedplus'
opt.breakindent = true
opt.undofile = true
opt.signcolumn = 'auto'
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
opt.scrolloff = 10
opt.list = true
opt.listchars = {
  tab = '»·',
  trail = '·',
  nbsp = '+',
  extends = '→',
  precedes = '←',
}
opt.fillchars = {
  stl = ' ',
  stlnc = '-',
  msgsep = ' ',
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.completeopt = 'menu,menuone,noselect,popup'

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'FileType' }, {
  pattern = { 'c', 'cpp', 'txt', 'c.snippets', 'cpp.snippets' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line
    if line '\'"' > 1 and line '\'"' <= line '$' then
      vim.cmd 'normal! g\'"'
    end
  end,
})
-- opt.virtualedit = 'block'
-- opt.conceallevel = 0
-- opt.colorcolume = 0
