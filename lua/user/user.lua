-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
require "user.copilot"

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
    "HerringtonDarkholme/yats.vim",
    event = "BufReadPre *.ts,*.tsx", -- Плагин загружается при открытии файлов TypeScript
  },
  {
    "tpope/vim-fugitive",
    event = "BufReadPost", -- Загружать плагин при открытии файла
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autotag = {
          enable = true, -- Включаем поддержку автозакрытия тегов
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").html.setup {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }
    end,
  },

  {
    "BufReadPre",
    callback = function()
      local line_count = vim.fn.line "$"
      if line_count > 10000 then vim.cmd "syntax off" end
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
      require "user.snippets"
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
