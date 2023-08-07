local M = {}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  --suggestion = {
  --  enable = true,
  --},
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },

  panel = {
    enable = false,
  },
  
  filetypes = {
    yaml = true,
    markdown = true,
    help = true,
    gitcommit = true,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    bash = true,
    --["."] = false,
  },

}

return M
