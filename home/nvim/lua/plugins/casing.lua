return {
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"ga", -- Default invocation prefix
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
		},
		cmd = {
			-- NOTE: The Subs command name can be customized via the option "substitude_command_name"
			"Subs",
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
		-- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
		-- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
		-- available after the first executing of it or after a keymap of text-case.nvim has been used.
		lazy = false,
	},
	{
		"bkad/CamelCaseMotion",
		config = function()
			vim.cmd([[map <silent> <M-w> <Plug>CamelCaseMotion_w]])
			vim.cmd([[map <silent> <M-b> <Plug>CamelCaseMotion_b]])
			vim.cmd([[map <silent> <M-e> <Plug>CamelCaseMotion_e]])
			vim.cmd([[map <silent> <M-g>e <Plug>CamelCaseMotion_ge]])
			vim.cmd([[sunmap <M-w>]])
			vim.cmd([[sunmap <M-b>]])
			vim.cmd([[sunmap <M-e>]])
			vim.cmd([[sunmap <M-g>e]])
		end,
	},
}
