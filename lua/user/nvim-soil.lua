return {
  "javiorfo/nvim-soil",
  lazy = true,
  ft = "plantuml",
  config = function()
    -- If you want to change default configurations
    require("soil").setup {
      -- If you want to use Plant UML jar version instead of the install version
      puml_jar = "/home/mose/work/repositories/icon/docs/plantuml-mit-1.2024.3.jar",

      -- If you want to customize the image showed when running this plugin
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "svg", -- Choose between png or svg

        -- This is a default implementation of using nsxiv to open the resultant image
        -- Edit the string to use your preferred app to open the image
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        execute_to_open = function(img)
          -- return "feh --conversion-timeout 1 " .. img
          -- return "eog " .. img
          return 0
        end,
      },
    }

    local customKeymap = require("utils.customKeymap").customKeymap

    -- Create or get an autocommand group for PlantUML setup
    local augroup = vim.api.nvim_create_augroup("PlantUMLSetup", { clear = true })

    local generate_svg_file = function()
      local settings = require("soil").DEFAULTS

      local puml_jar = settings.puml_jar
      local file_with_extension = vim.fn.expand "%:p"
      local format = settings.image.format
      local darkmode = settings.image.darkmode and "-darkmode" or ""

      local handle
      local args = { "-jar", puml_jar, "-t" .. format, file_with_extension }
      if settings.image.darkmode then
        table.insert(args, "-darkmode")
      end

      handle = vim.loop.spawn(
        "java",
        {
          args = args,
          stdio = { nil, nil, nil }, -- You can redirect input, output, and error if needed
        },
        vim.schedule_wrap(function(return_code)
          if return_code ~= 0 then
            vim.cmd "redraw"
            vim.notify("Failed to generate PlantUML SVG", vim.log.levels.ERROR)
          end
          handle:close()
        end)
      )
    end

    -- -- Use an autocommand to set the keymap for plantuml filetype buffers
    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = augroup,
    --   pattern = "plantuml",
    --   callback = function(args)
    --     -- Set custom keymap for generating PlantUML SVG image
    --     customKeymap("n", "<leader>s", '<CMD>lua require("soil.core").run()<CR>', "Generate PlantUML svg image")
    --   end,
    -- })

    -- Execute the command upon writing the file
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      pattern = { "*.puml" },
      callback = function()
        -- Execute the command to generate PlantUML SVG image
        generate_svg_file()
      end,
    })
  end,
}
