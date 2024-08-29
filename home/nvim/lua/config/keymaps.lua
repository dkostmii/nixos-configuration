-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set tab width to 2 spaces with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>t2",
	':set tabstop=2 shiftwidth=2 expandtab<CR>:lua vim.notify("Tab width set to 2 spaces")<CR>',
	{ noremap = true, silent = true, desc = "Set tab width 2 spaces wide" }
)

-- Set tab width to 4 spaces with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>t4",
	':set tabstop=4 shiftwidth=4 expandtab<CR>:lua vim.notify("Tab width set to 4 spaces")<CR>',
	{ noremap = true, silent = true, desc = "Set tab width 4 spaces wide" }
)

-- Set tab width to 8 spaces with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>t8",
	':set tabstop=8 shiftwidth=8 noexpandtab<CR>:lua vim.notify("Tab width set to 8 spaces")<CR>',
	{ noremap = true, silent = true, desc = "Set tab width 8 spaces wide" }
)

-- Toggle expandtab with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>te",
	':set expandtab!<CR>:lua vim.notify("Toggled expandtab")<CR>',
	{ noremap = true, silent = true, desc = "Toggle tab expansion" }
)

-- Enable expandtab with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>ee",
	':set expandtab<CR>:lua vim.notify("expandtab enabled")<CR>',
	{ noremap = true, silent = true, desc = "Enable tab expansion" }
)

-- Disable expandtab with notification
vim.api.nvim_set_keymap(
	"n",
	"<leader>ne",
	':set noexpandtab<CR>:lua vim.notify("expandtab disabled")<CR>',
	{ noremap = true, silent = true, desc = "Disable tab expansion" }
)
