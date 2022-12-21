--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map('i', 'jk', [[<ESC>]], {})

-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<CR>]], {})

-- Nivigate git repo
map('n', '<leader>g', [[:Git<CR>]], {})

-- Toggle floatting term
-- map('n', '<leader>t', [[:FloatermToggle<CR>]], {})

-- 
map('n', '<leader>s', [[:BLines<CR>]], {})

map('n', '<leader>l', [[:IndentLinesToggle<CR>]], {})


-- Toggle term
map('n', '<leader>t', [[:ToggleTerm<CR>]], {})
map('n', '<leader>tv', [[:ToggleTerm size=70 direction=vertical<CR>]], {})
map('n', '<leader>tf', [[:ToggleTerm direction=float <CR>]], {})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
