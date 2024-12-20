local cmp = require "cmp"

cmp.setup {
  mapping = {
    -- Маппинг для Shift+Enter
    ["<S-CR>"] = function(fallback)
      local copilot_accept = vim.fn["copilot#Accept"] "<CR>" -- Пробуем принять предложение Copilot
      if copilot_accept ~= "" then
        vim.api.nvim_feedkeys(copilot_accept, "n", true) -- Если Copilot предложил что-то, принимаем
      elseif cmp.visible() then
        cmp.confirm { select = true } -- Если видно меню nvim-cmp, подтверждаем выбор
      else
        fallback() -- Выполняем стандартное действие, если ничего не выбрано
      end
    end,
    -- Стандартное поведение Enter
    ["<CR>"] = function()
      vim.api.nvim_feedkeys("\n", "n", true) -- Выполняем перенос строки
    end,
  },
  sources = cmp.config.sources {
    { name = "copilot", priority = 1000 }, -- Copilot с высоким приоритетом
    { name = "nvim_lsp", priority = 800 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 300 },
  },
}

return {}
