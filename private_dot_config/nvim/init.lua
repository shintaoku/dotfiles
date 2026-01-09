--------------------------------------------------------------------
-- Basic Settings
--------------------------------------------------------------------
vim.g.vim_home_path = "~/.vim"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.background = "dark"
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
vim.cmd('syntax enable')

--------------------------------------------------------------------
-- Dracula Theme (dracula.nvim - Treesitter supported)
--------------------------------------------------------------------
require("dracula").setup({
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50FA7B",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
  },
  show_end_of_buffer = true,
  transparent_bg = false,
  italic_comment = true,
})
vim.cmd('colorscheme dracula')

--------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

require'nvim-treesitter.configs'.setup {
  -- Enable syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- Enable indentation
  indent = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

--------------------------------------------------------------------
-- Conform (formatter)
--------------------------------------------------------------------
require("conform").setup({
  formatters_by_ft = {
    cpp = { "clang_format" },
  },

  format_on_save = {
    lsp_fallback = true,
  },
})

--------------------------------------------------------------------
-- Gitsigns
--------------------------------------------------------------------
require('gitsigns').setup()

--------------------------------------------------------------------
-- LSP Configuration
--------------------------------------------------------------------
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_command([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    ]])
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

nvim_lsp["gopls"].setup { on_attach = on_attach }
nvim_lsp["zls"].setup {
  on_attach = on_attach,
  settings = {
    zls = {
      enable_inlay_hints = true,
      enable_semantic_tokens = true,
      enable_ast_check_diagnostics = true,
      enable_import_embedfile_subcommand = true,
      enable_autofix = true,
      enable_document_symbols = true,
      enable_completion = true,
      enable_go_to_definition = true,
      enable_hover = true,
      enable_references = true,
      enable_rename = true,
      enable_signature_help = true,
      enable_snippets = true,
      enable_type_information = true,
      enable_workspace_symbols = true,
      enable_format = true,
      enable_incremental_sync = true,
      enable_std_references = true,
      enable_std_symbols = true,
      enable_std_completion = true,
      enable_std_go_to_definition = true,
      enable_std_hover = true,
      enable_std_references = true,
      enable_std_rename = true,
      enable_std_signature_help = true,
      enable_std_snippets = true,
      enable_std_type_information = true,
      enable_std_workspace_symbols = true,
    }
  }
}

--------------------------------------------------------------------
-- CodeCompanion
--------------------------------------------------------------------
require("codecompanion").setup({
  adapters = {
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        env = {
          api_key = "cmd:op read op://Gemini/credential/notesPlain --no-newline",
        },
        schema = {
          model = {
            default = "gemini-1.5-pro",
          },
        },
      })
    end,
  },
  opts = {
    send_code = false,
  },
  display = {
    chat = {
      show_header_separator = true,
      show_references = true,
      show_token_count = true,
      window = {
        opts = {
          number = false,
          signcolumn = "no",
        },
      },
    },
  },
  strategies = {
    chat = {
      adapter = "gemini",
      keymaps = {
        send = {
          modes = { n = "<CR>", i = "<C-s>" },
        },
        completion = {
          modes = { i = "<C-/>" },
          callback = "keymaps.completion",
          description = "Completion Menu",
        },
      },
    },
    inline = {
      adapter = "gemini",
    },
  },
})

vim.keymap.set(
  { "n", "v" },
  "<C-a>",
  "<cmd>CodeCompanionActions<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  { "n" },
  "<C-c>",
  "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set(
  { "v" },
  "<C-c>",
  "<cmd>CodeCompanionChat Add<cr>",
  { noremap = true, silent = true }
)
