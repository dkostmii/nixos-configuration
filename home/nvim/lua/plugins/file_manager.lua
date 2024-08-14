return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})

			vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<cr>", {
				desc = "Toggle file manager",
				noremap = true,
			})
		end,
	},
}
