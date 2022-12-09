local map = vim.api.nvim_set_keymap
DEFAULT_OPTIONS = { noremap = true, silent = true }
map("n", "<F12>", ":wall! | compiler tsc | setlocal makeprg=yarn\\ tsc\\ --noEmit | make <CR><CR>",
  DEFAULT_OPTIONS)

require("lvim.lsp.manager").setup('eslint')
