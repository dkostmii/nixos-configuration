local trailingwhitespacehighlight_group = vim.api.nvim_create_augroup("TrailingWhitespaceHighlight", {})

local exclude_filetypes = {
	"dashboard",
	"neo-tree",
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end

		for _, filetype_to_exclude in ipairs(exclude_filetypes) do
			if string.find(vim.bo.filetype, filetype_to_exclude) ~= nil then
				vim.notify(vim.bo.filetype)
				return
			end
		end

		local bufnr = vim.api.nvim_get_current_buf()
		vim.b.trailing_whitespace_match_id = vim.fn.matchadd("TrailingWhitespace", "\\s\\+$", 0, -1, { bufnr = bufnr })
	end,
	group = trailingwhitespacehighlight_group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		if vim.b.trailing_whitespace_match_id == nil then
			return
		end

		if vim.bo.buftype == "" then
			return
		end

		local is_excluded_filetype = false
		for _, filetype_to_exclude in ipairs(exclude_filetypes) do
			if string.find(vim.bo.filetype, filetype_to_exclude) ~= nil then
				is_excluded_filetype = true
			end
		end

		if not is_excluded_filetype then
			return
		end

		vim.fn.matchdelete(vim.b.trailing_whitespace_match_id)
		vim.b.trailing_whitespace_match_id = nil
	end,
	group = trailingwhitespacehighlight_group,
})
