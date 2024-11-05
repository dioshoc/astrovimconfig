return  {
  {"nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    window = {
      mappings = {
        ["<leader>'"] = function(state)
          -- Получаем текущий выбранный узел (папку)
          local node = state.tree:get_node()

          -- Убедитесь, что мы находимся в директории
          if not node or node.type ~= "directory" then
            print("Пожалуйста, выберите директорию для создания компонента.")
            return
          end

          local current_path = node.path

          -- Запрашиваем у пользователя имя компонента
          vim.ui.input({ prompt = "Введите имя компонента: " }, function(input)
            if input == nil or input == "" then
              print("Имя компонента не указано.")
              return
            end

            -- Формируем полный путь к новой папке
            local component_path = current_path .. "/" .. input

            -- Создаём папку с именем компонента
            vim.fn.mkdir(component_path, "p")

            -- Выполняем команду создания файлов
            vim.cmd("CreateComponentFiles " .. input)

            -- Обновляем дерево после создания файлов
            require("neo-tree.sources.manager").refresh("filesystem")

            -- Перемещаем фокус на новый узел
            local new_node = state.tree:get_node(component_path)
            if new_node then
              require("neo-tree.sources.manager").focus_node(new_node.id)
            end
          end)
        end,
      },
    },
  }
}
