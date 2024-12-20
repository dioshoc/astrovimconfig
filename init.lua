-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
-- Подключение файла с маппингами
require "mappings"
local function create_component_files(args)
  -- Получаем имя компонента из аргументов
  local component_name = args.args

  -- Проверяем, указано ли имя компонента
  if component_name == "" or component_name == nil then
    print "Пожалуйста, укажите имя компонента."
    return
  end

  -- Создаём папку с именем компонента
  local dir = component_name
  vim.fn.mkdir(dir, "p")

  -- Строим пути для новых файлов внутри папки
  local view_file = dir .. "/" .. component_name .. ".view.tsx"
  local scss_file = dir .. "/" .. component_name .. ".scss"
  local type_file = dir .. "/" .. component_name .. ".type.ts"

  -- Содержимое для файла .view.tsx с динамическим именем компонента
  local view_content = string.format(
    [[
import React from 'react';

import * as utils from '@app/template-utils';
import * as constants from '@app/constants';
import * as Components from '@app/components';

import type { TemplateProps } from '@templates/organisms/Block';

const mainClass = '%s';

export default ({ common, className }: TemplateProps<'%s'>) => {
  const isSignIn = common?.player?.isSignedIn;

  return (
    <div className={utils.classnames(mainClass, className)}>
      <div></div>
    </div>
  );
  }]],
    component_name,
    component_name
  )

  -- Содержимое для файла .scss с динамическим именем компонента
  local scss_content = string.format(
    [[
@import '~styles/variables';

$name: '%s';

.#{$name} {
  
}
]],
    component_name
  )

  -- Содержимое для файла .type.ts с динамическим именем компонента
  local type_content = string.format(
    [[
export type T%s = {}
]],
    component_name
  )

  -- Записываем содержимое в .view.tsx файл
  local view_file_handle = io.open(view_file, "w")
  if view_file_handle then
    view_file_handle:write(view_content)
    view_file_handle:close()
  end

  -- Записываем содержимое в .scss файл
  local scss_file_handle = io.open(scss_file, "w")
  if scss_file_handle then
    scss_file_handle:write(scss_content)
    scss_file_handle:close()
  end

  -- Записываем содержимое в .type.ts файл
  local type_file_handle = io.open(type_file, "w")
  if type_file_handle then
    type_file_handle:write(type_content)
    type_file_handle:close()
  end

  -- Сообщаем об успешном создании файлов
  print("Созданы файлы для компонента " .. component_name .. " в папке " .. dir)
end
-- Добавляем команду в Neovim
vim.api.nvim_create_user_command("CreateComponentFiles", create_component_files, { nargs = 1 })
--
--
--
-- require("neo-tree").setup({
--   filesystem = {
--     follow_current_file = {
--       enabled = true,  -- Указываем, что нужно следовать за текущим файлом
--     },
--     hijack_netrw_behavior = "open_default", -- поведение захвата netrw
--     window = {
--       mappings = {
--         ["<leader>'"] = function(state)
--           -- Получаем текущий выбранный узел (папку)
--           local node = state.tree:get_node()
--
--           -- Убедитесь, что мы находимся в директории
--           if not node or node.type ~= "directory" then
--             print("Пожалуйста, выберите директорию для создания компонента.")
--             return
--           end
--
--           local current_path = node.path
--
--           -- Запрашиваем у пользователя имя компонента
--           vim.ui.input({ prompt = "Введите имя компонента: " }, function(input)
--             if input == nil or input == "" then
--               print("Имя компонента не указано.")
--               return
--             end
--
--             -- Формируем полный путь к новой папке
--             local component_path = current_path .. "/" .. input
--
--             -- Создаём папку с именем компонента
--             vim.fn.mkdir(component_path, "p")
--
--             -- Выполняем команду создания файлов
--             vim.cmd("CreateComponentFiles " .. input)
--
--             -- Обновляем дерево после создания файлов
--             require("neo-tree.sources.manager").refresh("filesystem")
--
--             -- Перемещаем фокус на новый узел
--             local new_node = state.tree:get_node(component_path)
--             if new_node then
--               require("neo-tree.sources.manager").focus_node(new_node.id)
--             end
--           end)
--         end,
--
--         ["<CR>"] = "open",          -- Открытие файла
--         ["<C-v>"] = "open_vsplit",  -- Открытие в новом вертикальном сплите
--         ["<C-x>"] = "open_split",   -- Открытие в новом сплите
--         ["<leader>r"] = "refresh",   -- Обновление дерева
--         ["<leader>m"] = "move",      -- Перемещение файла (должно работать)
--         ["<leader>d"] = "delete",    -- Удаление файла (должно работать)
--         ["<leader>c"] = "copy",      -- Копирование файла (должно работать)
--         ["<leader>n"] = "create",    -- Создание файла (должно работать)
--       },
--     },
--   },
-- })

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.api.nvim_set_keymap("n", "<leader>G", ":CopilotChat<CR>", { noremap = true, silent = true })

require("nvim-treesitter.configs").setup {
  ensure_installed = { "javascript", "typescript", "tsx", "html" }, -- Установим нужные языки
  highlight = {
    enable = true, -- Включаем подсветку синтаксиса
  },
}

vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = { "javascriptreact", "typescriptreact" },
  callback = function()
    local ts_utils = require "nvim-treesitter.ts_utils"
    local node = ts_utils.get_node_at_cursor()

    -- Проверяем, находится ли курсор внутри JSX элемента
    if node and node:type() == "jsx_element" then
      -- Если да, запускаем emmet-ls
      local clients = vim.lsp.get_active_clients { bufnr = 0 }
      for _, client in ipairs(clients) do
        if client.name == "emmet_ls" then return end
      end
      -- Запускаем emmet_ls для jsx
      require("lspconfig").emmet_ls.setup {
        filetypes = { "javascriptreact", "typescriptreact" },
      }
    end
  end,
})
