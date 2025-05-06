return {
  'voldikss/vim-floaterm',
  keys = {
    { '<leader><Enter>', ':FloatermToggle<CR>' },
    { '<leader><Enter>', '<Esc>:FloatermToggle<CR>', mode = 'i' },
    { '<leader><Enter>', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
  },
  cmd = { 'FloatermToggle' },
  init = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
  end,
}
