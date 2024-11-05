
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "mattn/emmet-vim",
    event="BufRead"
  },
  {
    "HerringtonDarkholme/yats.vim",
    event = "BufReadPre *.ts,*.tsx",  -- Плагин загружается при открытии файлов TypeScript
  },
  {
    "tpope/vim-fugitive",
    event = "BufReadPost",  -- Загружать плагин при открытии файла
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
        
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lspconfig').html.setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
"        ██╗  ██╗ ██████╗ ██╗  ██╗   ██╗ █████╗     ",
"        ██║ ██╔╝██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗    ",
"        █████╔╝ ██║   ██║██║   ╚████╔╝ ███████║    ",
"        ██╔═██╗ ██║   ██║██║    ╚██╔╝  ██╔══██║    ",
"        ██║  ██╗╚██████╔╝███████╗██║   ██║  ██║    ",
"        ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝  ╚═╝    ",
"                                                  ",
"             ██████╗ ██████╗ ██████╗ ██╗████████╗  ",
"            ██╔════╝██╔═══██╗██╔══██╗██║╚══██╔══╝  ",
"            ██║     ██║   ██║██║  ██║██║   ██║     ",
"            ██║     ██║   ██║██║  ██║██║   ██║     ",
"            ╚██████╗╚██████╔╝██████╔╝██║   ██║     ",
"             ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝   ╚═╝     ",
"                                                   ",
"                   ██████╗ ██████╗ ██████╗ ██████╗ ",
"                  ██╔════╝██╔═══██╗██╔══██╗██╔═══╝ ",
"                  ██║     ██║   ██║██║  ██║██████╗ ",
"                  ██║     ██║   ██║██║  ██║██╔═══╝ ",
"                  ╚██████╗╚██████╔╝██████╔╝██████╗ ",
"                   ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝ ",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
