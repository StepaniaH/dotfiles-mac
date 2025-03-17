return {
  {
    "neovim/nvim-lspconfig",
    enable = false,
    dependencies = {
      { "saghen/blink.cmp" },
    },
    config = function()
      -- Lua language serve
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      -- C language serve
      require('lspconfig').clangd.setup {}
      -- Python language serve
      require('lspconfig').pyright.setup {}

      -- Auto formatting when save
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
