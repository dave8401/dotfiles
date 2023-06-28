-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
DEFAULT_OPTIONS = { noremap = true, silent = true }
EXPR_OPTIONS = { noremap = true, expr = true, silent = true }

vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.showcmdloc = "statusline"

map("n", "<Space>", "<NOP>", DEFAULT_OPTIONS)
vim.g.mapleader = " "

-- Use <leader>d to delete without adding it to the default register
map("v", "<leader>d", '"_d', DEFAULT_OPTIONS)

-- apply the same to ,x
map("v", "<leader>x", '"_x', DEFAULT_OPTIONS)

-- paste and keep the  p register
map("x", "<leader>p", '"_dP', DEFAULT_OPTIONS)

-- copy the current word or visually selected text to the clipboard
map("n", "<leader>y", '"+yiw', DEFAULT_OPTIONS)
map("v", "<leader>y", '"+y', DEFAULT_OPTIONS)

-- copy entire buffer
map("n", "<leader>Y", ':%y+<CR>', DEFAULT_OPTIONS)

-- select from beginnig to end of line
map("n", "<leader>v", "v_o$", DEFAULT_OPTIONS)

-- copy relative path
map("n", "cp", ':let @+=fnamemodify(expand("%"), ":~:.")<CR>', DEFAULT_OPTIONS)

-- Remap colon
map("n", "ö", ":", { noremap = true })
-- map("n", ";;", ";", { noremap = true })
map("n", ";", ":", { noremap = true })
map("n", ":", ";", { noremap = true })
map("v", ";", ":", { noremap = true })
map("v", ":", ";", { noremap = true })

--Save
map("i", "<C-s>", "<C-o>:up<CR>", { noremap = true })
map("n", "<C-s>", ":up<CR>", { noremap = true })

-- ESC terminal
map("t", "<C-t>", "<C-\\><C-n>", DEFAULT_OPTIONS)

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

map("n", "<leader>0", ":set notimeout<cr>", DEFAULT_OPTIONS)
map("n", "<leader>)", ":set timeout<cr>", DEFAULT_OPTIONS)

map("n", "<C-d>", "<C-d>zz", DEFAULT_OPTIONS)
map("n", "<C-u>", "<C-u>zz", DEFAULT_OPTIONS)

map("n", "]d", function() vim.diagnostic.goto_next() end, DEFAULT_OPTIONS)
map("n", "[d", function() vim.diagnostic.goto_prev() end, DEFAULT_OPTIONS)

map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, EXPR_OPTIONS)

-- theme
-- local c = require('gruvbox-baby.colors').config()
-- vim.g.gruvbox_baby_telescope_theme = 1
-- vim.g.gruvbox_baby_background_color = 'dark'
-- vim.g.gruvbox_baby_use_original_palette = false
-- vim.g.gruvbox_baby_transparent_mode = true
-- vim.g.gruvbox_baby_highlights = {
--   --  -- Search = { fg = c.background, bg = c.medium_gray },
--   --  Search = { bg = c.medium_gray },
--   -- QuickFixLine = { fg = c.background, bg = c.medium_gray }
--   QuickFixLine = { bg = c.light_gray }
-- }

-- lvim
lvim.format_on_save = true
lvim.log.level = "warn"
lvim.colorscheme = "kanagawa"
lvim.leader = "space"
lvim.builtin.which_key.setup.plugins.registers = true
lvim.keys.normal_mode["<C-t>"] = ":ToggleTerm<cr>"

lvim.builtin.telescope.defaults.file_ignore_patterns = { ".yarn", "node_modules" }
lvim.builtin.telescope.defaults.borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
-- https://github.com/LunarVim/LunarVim/issues/2286#issuecomment-1049097981
lvim.builtin.telescope.defaults.layout_config = {
  width = 0.90,
  height = 0.85,
  -- preview_cutoff = 120,
  prompt_position = "top",
  horizontal = {
    preview_width = function(_, cols, _)
      return math.floor(cols * 0.6)
    end,
  },
  vertical = {
    width = 0.9,
    height = 0.85,
    preview_height = 0.5,
  },
  flex = {
    horizontal = {
      preview_width = 0.9,
    },
  },
}
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.which_key.mappings["f"] = {
  function()
    require("lvim.core.telescope.custom-finders").find_project_files()
  end,
  "Find Project Files",
}
lvim.builtin.which_key.mappings["s"]["f"] = {
  function()
    require "telescope.builtin".find_files({
      hidden = true,
      no_ignore = true
    })
  end,
  "Find File",
}

lvim.builtin.which_key.mappings["lA"] = {
  "<cmd>TypescriptAddMissingImports<CR>", "Import All"
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

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

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
lvim.builtin.cmp.formatting.max_width = 50

-- generic LSP settings
-- lvim.lsp.diagnostics.virtual_text = false
vim.diagnostic.config({
  virtual_text = false,
})
-- lvim.lsp.diagnostics.float.format = nil

-- Additional Plugins
lvim.plugins = {
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest-python",
  "nvim-neotest/neotest",
  -- {
  --   "David-Kunz/jester",
  --   config = function()
  --     require("jester").setup({
  --       path_to_jest_run = 'yarn jest',   -- used to run tests
  --       path_to_jest_debug = 'yarn jest', -- used for debugging
  --       dap = {
  --         -- console = "externalTerminal",
  --       }
  --     })
  --   end
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
      "neotest-python",
      "haydenmeade/neotest-jest",
      -- Your other test adapters here
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        -- output = {
        --   enable = true,
        --   open_on_run = true,
        -- },
        -- output_panel = {
        --   open = 'rightbelow vsplit | resize 30',
        -- },
        adapters = {
          require('neotest-jest')({
            jestCommand = "yarn test --",
            -- jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function()
              -- return "/Users/davidsteinberger/Documents/myplant/github/maintenance-operations-app/"
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-go"),
          require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = {
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet" },
            runner = "pytest",
          })

        },
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
  },
  {

    'eandrju/cellular-automaton.nvim'
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({})
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- { "hrsh7th/cmp-nvim-lsp-signature-help" },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              }
            }
          }
        }
      })
      require("kanagawa").load("wave")
    end
  },
  {
    'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
      });
    end
  },
  {
    "christoomey/vim-tmux-navigator"
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = false,
      })
    end,
  },
  { "luisiacc/gruvbox-baby" },
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
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ";HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ";HopWord<cr>", { silent = true })
    end,
  },
  {
    "github/copilot.vim"
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  }
}

--markdown
vim.g.mkdp_auto_close = 0

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
map("i", "<C-Y>", 'copilot#Accept("<CR>")', { noremap = true, expr = true, silent = true, replace_keycodes = false })
map("i", "<C-J>", 'copilot#Previous()', EXPR_OPTIONS)
map("i", "<C-K>", 'copilot#Next()', EXPR_OPTIONS)
-- local cmp = require "cmp"
-- lvim.builtin.cmp.mapping["<C-H>"] = function(fallback)
--   cmp.mapping.abort()
--   local copilot_keys = vim.fn["copilot#Accept"]()
--   if copilot_keys ~= "" then
--     vim.api.nvim_feedkeys(copilot_keys, "i", true)
--   else
--     fallback()
--   end
-- end
vim.list_extend(lvim.builtin.cmp.sources, {
  { name = "nvim_lsp_signature_help" },
}, 1, 1)

-- null-ls
local null_ls = require("null-ls")

local command_resolver = require("null-ls.helpers.command_resolver")
local is_pnp = vim.fn.findfile('.pnp.cjs', '.;') ~= ''

local with_yarn_pnp = function(source)
  return source.with({
    dynamic_command = is_pnp and command_resolver.from_yarn_pnp() or nil,
    -- dynamic_command = nil
  })
end

local sources = {
  with_yarn_pnp(null_ls.builtins.formatting.prettier),
  with_yarn_pnp(null_ls.builtins.diagnostics.eslint),
  with_yarn_pnp(null_ls.builtins.code_actions.eslint)
}

null_ls.register({ sources = sources })

vim.api.nvim_create_user_command("NullLsToggle", function()
  require("null-ls").toggle({})
end, {})

vim.g.diagnostics_virtual = false
vim.api.nvim_create_user_command("DiagnosticVirtual", function()
  if vim.g.diagnostics_virtual then
    vim.g.diagnostics_virtual = false
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.g.diagnostics_virtual = true
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

vim.g.transparent = false
vim.api.nvim_create_user_command("TransparentToggle", function()
  local theme = vim.g.colors_name
  if vim.g.transparent then
    vim.g.transparent = false
    require('kanagawa').setup({ transparent = false, theme = theme })
  else
    vim.g.transparent = true
    require('kanagawa').setup({ transparent = true, theme = theme })
  end
  print("theme: " .. theme)
  vim.cmd.colorscheme(theme)
end, {})

-- experimental

lvim.lsp.installer.setup.automatic_installation.exclude = { "eslint" }
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "eslint" }, 1, 1)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" }, 1, 1)
require("lvim.lsp.manager").setup("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'tw`([^`]*)',
          'tw="([^"]*)',
          'tw={"([^"}]*)',
          'tw\\.\\w+`([^`]*)',
          'tw\\(.*?\\)`([^`]*)',
        },
      },
    },
  },
})

lvim.builtin.dap.active = true
local dap = require("dap")

-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = { 'dap', '-l', '127.0.0.1:${port}' },
--   }
-- }
-- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }
