-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    -- 'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- require('mason-nvim-dap').setup {
    --   -- Makes a best effort to setup the various debuggers with
    --   -- reasonable debug configurations
    --   automatic_setup = true,
    --
    --
    --   -- You'll need to check that you have the required things installed
    --   -- online, please don't ask me how to install them :)
    --   ensure_installed = {
    --     -- Update this to ensure that you have the debuggers for the langs you want
    --     'delve',
    --     -- 'codelldb',
    --   },
    --
    --   -- You can provide additional configuration to the handlers,
    --   -- see mason-nvim-dap README for more information
    --   handlers = {
    --     function(config)
    --       -- all sources with no handlers get passed here
    --       -- Keep original functionality
    --       require('mason-nvim-dap').default_setup(config)
    --     end,
    --     codelldb = function(config)
    --       config.adapters = {
    --         executable = {
    --           args = { "--port", "${port}" },
    --           command = vim.fn.exepath("codelldb"),
    --         },
    --         port = "${port}",
    --         type = "server"
    --       }
    --       require('mason-nvim-dap').default_setup(config) -- don't forget this!
    --     end,
    --     -- delve = {
    --     --   executable = {
    --     --     args = { "dap", "-l", "127.0.0.1:${port}" },
    --     --     command = vim.fn.exepath("dlv"),
    --     --   },
    --     --   port = "${port}",
    --     --   type = "server"
    --     -- },
    --   },
    -- }
    --

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = 'codelldb',
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    }
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input({
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/',
            completion = 'file'
          })
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F8>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸️',
          play = '▶️',
          step_into = '⬇️',
          step_over = '⤵️',
          step_out = '⬆️',
          step_back = 'b',
          run_last = '🔁',
          terminate = '⏹️',
          disconnect = '⏏️',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
