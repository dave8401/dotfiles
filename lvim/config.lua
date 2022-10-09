local map = vim.api.nvim_set_keymap
DEFAULT_OPTIONS = { noremap = true, silent = true }
EXPR_OPTIONS = { noremap = true, expr = true, silent = true }

vim.cmd([[
" Use <leader>d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d
" apply the same to ,x
nnoremap <silent> <leader>x "_x
vnoremap <silent> <leader>x "_x

" paste and keep the  p register
xnoremap <leader>p "_dP

" turn off reference hightlight
" autocmd FileType * hi! link LspReferenceText 0

" copy the current word or visually selected text to the clipboard
autocmd FileType * nnoremap <buffer> <nowait> <leader>y "+yiw
vnoremap <leader>y "+y

" copy entire buffer
autocmd FileType * nnoremap <leader>Y :%y+<CR>

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" copy relative path
nnoremap cp :let @+=fnamemodify(expand("%"), ":~:.")<CR>

function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction
command! QuickFixOpenAll         call QuickFixOpenAll()
]])

vim.opt.relativenumber = true

map("n", "<Space>", "<NOP>", DEFAULT_OPTIONS)
vim.g.mapleader = " "

-- Remap colon
map("n", "ö", ":", { noremap = true })
map("n", "<leader>ö", "q:", { noremap = true })
map("v", "öö", "<ESC>", DEFAULT_OPTIONS);
map("n", "ä", ":nohlsearch<CR>", DEFAULT_OPTIONS);

--Save
map("i", "<C-s>", "<C-o>:w<cr>", DEFAULT_OPTIONS)
map("n", "<C-s>", ":w<cr>", DEFAULT_OPTIONS)

-- ESC terminal
map("t", "<Esc>", "<C-\\><C-n>", DEFAULT_OPTIONS)

-- Deal with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", EXPR_OPTIONS)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", EXPR_OPTIONS)

-- Tab switch buffer
map("n", "<TAB>", ":bnext<CR>", DEFAULT_OPTIONS)
map("n", "<S-TAB>", ":bprevious<CR>", DEFAULT_OPTIONS)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", DEFAULT_OPTIONS)

-- Resizing panes
map("n", "<Left>", ":vertical resize -1<CR>", DEFAULT_OPTIONS)
map("n", "<Right>", ":vertical resize +1<CR>", DEFAULT_OPTIONS)
map("n", "<Up>", ":resize -1<CR>", DEFAULT_OPTIONS)
map("n", "<Down>", ":resize +1<CR>", DEFAULT_OPTIONS)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", DEFAULT_OPTIONS)
map("x", "J", ":move '>+1<CR>gv-gv", DEFAULT_OPTIONS)

map("n", "<leader>9", ":set notimeout<cr>", DEFAULT_OPTIONS)
map("n", "<leader>)", ":set timeout<cr>", DEFAULT_OPTIONS)

-- lvim
lvim.log.level = "warn"
lvim.format_on_save = true
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_background_color = 'dark'
vim.g.gruvbox_baby_use_original_palette = false
-- vim.g.gruvbox_baby_transparent_mode = 1
lvim.colorscheme = "gruvbox-baby"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.telescope.defaults.file_ignore_patterns = { ".yarn", "node_modules" }
lvim.builtin.which_key.mappings["lA"] = {
  "<cmd>TSLspImportAll<CR>", "Import All"
}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
  t = { "<cmd>DiagnosticToggle<cr>", "Toggle Diagnostics" },
  v = { "<cmd>DiagnosticVirtual<cr>", "Toggle Diagnostics Virtual" },
}

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  -- { "morhetz/gruvbox" },
  -- { "gruvbox-community/gruvbox", },
  -- { "ellisonleao/gruvbox.nvim" },
  { "luisiacc/gruvbox-baby" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" }
  },
  {
    "sidebar-nvim/sidebar.nvim",
    config = function()
      require("sidebar-nvim").setup({ open = false, side = "right" })
    end
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "github/copilot.vim"
  },
}

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
map("i", "<C-H>", 'copilot#Accept("<CR>")', EXPR_OPTIONS)
map("i", "<C-J>", 'copilot#Previous()', EXPR_OPTIONS)
map("i", "<C-K>", 'copilot#Next()', EXPR_OPTIONS)
local cmp = require "cmp"
-- lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
--   ["<C-j>"] = nil
-- })
lvim.builtin.cmp.mapping["<C-H>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end
-- lvim.builtin.cmp.completion.keyword_length = 2
-- lvim.builtin.telescope.defaults.layout_config.width = 0.95
-- lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75

lvim.builtin.cmp.formatting.max_width = 50

-- generic LSP settings
lvim.lsp.diagnostics.virtual_text = true

local null_ls = require("null-ls")

vim.api.nvim_create_user_command("NullLsToggle", function()
  require("null-ls").toggle({})
end, {})

vim.g.dianostics_virtual = true
vim.api.nvim_create_user_command("DiagnosticVirtual", function()
  if vim.g.dianostics_virtual then
    vim.g.dianostics_virtual = false
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.g.dianostics_virtual = true
    vim.diagnostic.config({ virtual_text = true })
  end
end, {})

vim.g.diagnostics_active = true
vim.api.nvim_create_user_command("DiagnosticToggle", function()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end, {})

local command_resolver = require("null-ls.helpers.command_resolver")
local is_pnp = vim.fn.findfile('.pnp.cjs', '.')

local with_yarn_pnp = function(source)
  return source.with({
    dynamic_command = is_pnp and command_resolver.from_yarn_pnp() or nil,
  })
end

local sources = {
  -- prettier,
  with_yarn_pnp(null_ls.builtins.formatting.prettier),
  -- eslint, -- = with_yarn_pnp(null_ls.builtins.diagnostics.eslint),
  with_yarn_pnp(null_ls.builtins.diagnostics.eslint),
  -- eslint_action, -- = with_yarn_pnp(null_ls.builtins.code_actions.eslint),
  with_yarn_pnp(null_ls.builtins.code_actions.eslint)
}

null_ls.register({ sources = sources })

-- nvim-lsp-ts-utils
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
  -- Needed for inlayHints. Merge this table with your settings or copy
  -- it from the source if you want to add your own init_options.
  init_options = require("nvim-lsp-ts-utils").init_options,
  --
  on_attach = function(client, _)
    local ts_utils = require("nvim-lsp-ts-utils")

    -- disable tsserver formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},

      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
        -- Example format customization for `Type` kind:
        -- Type = {
        --     highlight = "Comment",
        --     text = function(text)
        --         return "->" .. text:sub(2)
        --     end,
        -- },
      },

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      watch_dir = nil,
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    -- local opts = { silent = true }
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end,
})
