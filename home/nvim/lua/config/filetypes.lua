vim.filetype.add({
  extension = {
    mako = "python",
  },
  pattern = {
    ["requirements.txt"] = "requirements",
  },
})
