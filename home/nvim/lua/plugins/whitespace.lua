return {
  "dkostmii/highlight-whitespace",
  opts = {
    tws = "\\s\\+$",
    clear_on_bufleave = true,
    palette = {
      other = {
        tws = 'Red',
        ['\\(\\S\\)\\@<=\\s\\{2,\\}\\(\\S\\)\\@='] = 'Yellow',
      }
    }
  }
}
