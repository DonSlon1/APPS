-- DAP (Debug Adapter Protocol) configuration for debugging

return {
  -- Main DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      -- Virtual text for DAP
      "theHamsta/nvim-dap-virtual-text",
      -- Mason integration for DAP
      "jay-babu/mason-nvim-dap.nvim",
      -- Telescope integration
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup Mason DAP
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "cppdbg" },
        automatic_installation = true,
        handlers = {},
      })

      -- C/C++ debugging configuration
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap", -- adjust path as needed
        name = "lldb"
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = {"--port", "${port}"},
        }
      }

      -- C/C++ configurations
      dap.configurations.c = {
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Launch (LLDB)",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Launch (CodeLLDB)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach to process",
          type = "gdb",
          request = "attach",
          pid = require('dap.utils').pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      -- Use the same configuration for C++
      dap.configurations.cpp = dap.configurations.c

      -- Setup DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        element_mappings = {},
        expand_lines = true,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -- Auto-open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Set breakpoint icons
      vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='◆', texthl='DapBreakpointCondition', linehl='', numhl=''})
      vim.fn.sign_define('DapLogPoint', {text='◆', texthl='DapLogPoint', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='▶', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})
      vim.fn.sign_define('DapBreakpointRejected', {text='✖', texthl='DapBreakpointRejected', linehl='', numhl=''})
    end,
    keys = {
      -- Debugging keymaps
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug: Set Conditional Breakpoint" },
      { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Debug: Set Log Point" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug: Open REPL" },
      { "<leader>dR", function() require("dap").run_last() end, desc = "Debug: Run Last" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Debug: Eval", mode = {"n", "v"} },
      { "<leader>dE", function() require("dapui").eval(vim.fn.input('Expression: ')) end, desc = "Debug: Eval Expression" },
      { "<leader>df", function() require("dapui").float_element() end, desc = "Debug: Float Element" },
      { "<leader>ds", function() require("dap").session() end, desc = "Debug: Session" },
      { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Debug: Run to Cursor" },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Debug: Hover Variables" },
      { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Debug: Scopes" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Debug: Pause" },
      { "<leader>dC", function() require("dap").clear_breakpoints() end, desc = "Debug: Clear All Breakpoints" },
      { "<leader>dL", function() require("dap").list_breakpoints() end, desc = "Debug: List Breakpoints" },
    },
  },
}