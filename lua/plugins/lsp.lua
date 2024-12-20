return {
  "AstroNvim/astrolsp",
  opts = {
    setup = {
      emmet_ls = function(_, opts)
        require("lspconfig").emmet_ls.setup(vim.tbl_deep_extend("force", opts, {
          filetypes = { "html", "javascriptreact", "typescriptreact" }, -- Только JSX и HTML
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true, -- Включение BEM, если нужно
              },
            },
          },
        }))
        return true
      end,
    },
  },
}
