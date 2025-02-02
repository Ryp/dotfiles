-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "<F5>", ":make<CR>", { noremap = true, silent = true })
