M = {
  "javiorfo/nvim-soil",
  lazy = true,
  ft = "plantuml",
  config = function()
    -- If you want to change default configurations
    require("soil").setup({
      -- If you want to use Plant UML jar version instead of the install version
      puml_jar = vim.fn.stdpath("config") .. "/plantuml.jar",

      -- If you want to customize the image showed when running this plugin
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "svg", -- Choose between png or svg

        execute_to_open = function(img)
          return 0
        end,
      },
    })

    local customKeymap = require("utils.customKeymap").customKeymap

    -- Create or get an autocommand group for PlantUML setup
    local augroup = vim.api.nvim_create_augroup("PlantUMLSetup", { clear = true })

    -- Use an autocommand to set the keymap for plantuml filetype buffers
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "plantuml",
      callback = function(args)
        -- Set custom keymap for generating PlantUML SVG image
        customKeymap(
          "n",
          "<leader>s",
          '<CMD>lua require("user.nvim-soil").open_image()<CR>',
          "Generate PlantUML svg image"
        )
      end,
    })

    -- Execute the command upon writing the file
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      pattern = { "*.puml" },
      callback = function()
        -- Execute the command to generate PlantUML SVG image
        M.generate_image_file()
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = augroup,
      callback = function()
        if vim.g.nvim_soil_feh_pid then
          -- Use a system command to kill the feh process
          vim.fn.jobstart({ "kill", vim.g.nvim_soil_feh_pid })
          vim.g.nvim_soil_feh_pid = nil -- Clear the PID
        end
      end,
    })
  end,
}

M.generate_image_file = function(format)
  local settings = require("soil").DEFAULTS
  local puml_jar = settings.puml_jar
  local file_with_extension = vim.fn.expand("%:p")
  format = format or settings.image.format

  local args = { "-jar", puml_jar, "-t" .. format, file_with_extension }
  if settings.image.darkmode then
    table.insert(args, "-darkmode")
  end

  vim.loop.spawn(
    "java",
    {
      args = args,
      stdio = { nil, nil, nil }, -- You can redirect input, output, and error if needed
    },
    vim.schedule_wrap(function(return_code)
      if return_code ~= 0 then
        vim.cmd("redraw")
        vim.notify("Failed to generate PlantUML SVG", vim.log.levels.ERROR)
      end
    end)
  )
end

M.open_image = function()
  local settings = require("soil").DEFAULTS
  local file = vim.fn.expand("%:p:r")
  local image_file = string.format("%s.%s", file, settings.image.format)

  if vim.g.nvim_soil_feh_pid == nil then
    local handle
    handle = vim.loop.spawn(
      "feh",
      {
        args = { "--keep-zoom-vp", "-R", "1", "--conversion-timeout", "1", image_file },
        stdio = { nil, nil, nil },
      },
      vim.schedule_wrap(function(return_code)
        vim.g.nvim_soil_feh_pid = nil -- Clear the PID
        if return_code ~= 0 then
          vim.cmd("redraw")
          vim.notify("Failed to open PlantUML diagram.", vim.log.levels.ERROR)
        end
      end)
    )
    -- Store the PID for later use
    local pid = handle:get_pid()
    vim.g.nvim_soil_feh_pid = pid -- Use a global variable, or another method to store the PID
  end
end

return M
