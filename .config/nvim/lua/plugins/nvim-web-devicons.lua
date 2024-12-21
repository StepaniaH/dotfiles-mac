return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- Enabled by default
      enabled = true,
      -- Default display icon
      default = true,
    })
  end,
}
