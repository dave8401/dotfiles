local map = vim.api.nvim_set_keymap
DEFAULT_OPTIONS = { noremap = true, silent = true }
map("n", "<Leader>cy", ":compiler tsc | set makeprg=yarn\\ tsc\\ --noEmit<CR>", DEFAULT_OPTIONS)
map("n", "<Leader>cn", ":compiler tsc | set makeprg=npm\\ run\\ tsc\\ --noEmit<CR>", DEFAULT_OPTIONS)
map("n", "<Leader>cc", ":Make<CR>", DEFAULT_OPTIONS)
