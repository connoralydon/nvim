-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "nix" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- local nvim_lsp = require("lspconfig")
-- nvim_lsp.nil_ls.setup({
--   settings = {
--     ["nil"] = {
--       formatting = {
--         command = { "nixfmt" },
--       },
--     },
--   },
-- })
