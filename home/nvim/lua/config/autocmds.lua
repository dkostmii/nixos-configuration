local whitespacehighlight_group = vim.api.nvim_create_augroup('WhitespaceHighlight', {})

local exclude_filetypes = {
  'dashboard',
  'neo-tree',
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'BufReadPost', 'UIEnter', 'WinEnter' }, {
  pattern = '*',
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local win_id = vim.fn.bufwinid(bufnr)

    for _, filetype_to_exclude in ipairs(exclude_filetypes) do
      if string.find(vim.bo.filetype, filetype_to_exclude) ~= nil then
        if vim.b.trailing_whitespace_match_id ~= nil then
          vim.fn.matchdelete(vim.b.trailing_whitespace_match_id, win_id)
          vim.b.trailing_whitespace_match_id = nil
        end
        return
      end
    end

    vim.b.trailing_whitespace_match_id = vim.fn.matchadd('TrailingWhitespace', '\\s\\+$', 0, -1, { window = win_id })
  end,
  group = whitespacehighlight_group,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'BufReadPost', 'UIEnter', 'WinEnter' }, {
  pattern = '*',
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local win_id = vim.fn.bufwinid(bufnr)

    for _, filetype_to_exclude in ipairs(exclude_filetypes) do
      if string.find(vim.bo.filetype, filetype_to_exclude) ~= nil then
        if vim.b.inter_word_whitespace_match_id ~= nil then
          vim.fn.matchdelete(vim.b.inter_word_whitespace_match_id, win_id)
          vim.b.inter_word_whitespace_match_id = nil
        end
        return
      end
    end

    vim.b.inter_word_whitespace_match_id = vim.fn.matchadd('InterWordWhitespace', '\\(\\S\\)\\@<=\\s\\{2,\\}\\(\\S\\)\\@=', 0, -1, { window = win_id })
  end,
  group = whitespacehighlight_group,
})
