local opt = vim.opt
-- Numeros relativos y lo de inccommand
opt.relativenumber = true
opt.inccommand = "split"


--------------- Para pruebas que me encuentro para hacer más bonito nvim xd -----------------

-- local g = vim.g
--local yC = vim.highlight

-- Para dar color cuando copio algo xd
--yC.on_yank{higroup="IncSearch", timeout=400, on_visual=true}

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 400 }
  end,
})
