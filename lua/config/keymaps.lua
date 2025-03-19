-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- centering when grep searching
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- centering when you go up and down
map("n", "j", "jzz")
map("n", "k", "kzz")

-- centering when page up, page down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- harpoon
map("n", "gm", "<cmd>Telescope lsp_references<cr>")
map("v", "gm", "<cmd>Telescope lsp_references<cr>")

map("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
map("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
map(
  "n",
  "<leader>hd",
  "<cmd>lua require('harpoon.mark').rm_file()<CR><cmd>w<CR><cmd>lua require('harpoon.ui').nav_prev()<CR>"
)

-- harpoon hook navigation
map("n", "<leader>h1", "<cmd>lua require('harpoon.mark').nav_file(1)<CR>")
map("n", "<leader>h2", "<cmd>lua require('harpoon.mark').nav_file(2)<CR>")
map("n", "<leader>h3", "<cmd>lua require('harpoon.mark').nav_file(3)<CR>")
map("n", "<leader>h4", "<cmd>lua require('harpoon.mark').nav_file(4)<CR>")
map("n", "<leader>h5", "<cmd>lua require('harpoon.mark').nav_file(5)<CR>")
map("n", "<leader>h6", "<cmd>lua require('harpoon.mark').nav_file(6)<CR>")
map("n", "<leader>h7", "<cmd>lua require('harpoon.mark').nav_file(7)<CR>")
map("n", "<leader>h8", "<cmd>lua require('harpoon.mark').nav_file(8)<CR>")
map("n", "<leader>h9", "<cmd>lua require('harpoon.mark').nav_file(9)<CR>")

-- avante
map("n", "<leader>ax", "<cmd>AvanteClear<CR>")

-- tab through hooks
map("n", "9", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
map("n", "8", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")

-- -- grep search in the cwd
-- map("n", "<leader>/", "<cmd>Telescope live_grep (CWD)<cr>")
--
-- -- file search in the cwd
-- map("n", "<leader> ", "<cmd>Telescope find_files (CWD)<cr>")
