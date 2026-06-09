return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Only loads when you start typing to keep startup fast
  opts = {
    check_ts = true, -- Leverage treesitter syntax parsing if available
    disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- Don't break layout windows
  },
}
