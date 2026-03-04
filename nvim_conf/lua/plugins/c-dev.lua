-- C/C++ specific development plugins and settings

return {
  -- Better syntax highlighting for C/C++
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    config = function()
      require("clangd_extensions").setup({
        -- Server setup is handled by lsp/c.lua — don't duplicate it here
        extensions = {
          -- Disable legacy inlay hints; Neovim 0.11 native vim.lsp.inlay_hint is used instead
          autoSetHints = false,
          hover_with_actions = true,
          ast = {
            role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
            },
            kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
            },
          },
        },
      })
    end,
  },

  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        ctest_command = "ctest",
        cmake_regenerate_on_save = true,
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_build_directory = "build",
        cmake_soft_link_compile_commands = true,
        cmake_compile_commands_from_lsp = false,
        cmake_kits_path = nil,
        cmake_variants_message = {
          short = { show = true },
          long = { show = true, max_length = 40 },
        },
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_executor = {
          name = "quickfix",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true,
            },
            toggleterm = {
              direction = "float",
              close_on_exit = false,
              auto_scroll = true,
            },
            overseer = {
              new_task_opts = {},
              on_new_task = function(task) end,
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ",
              split_direction = "horizontal",
              split_size = 11,
              single_terminal_per_instance = true,
              single_terminal_per_tab = true,
              keep_terminal_static_location = true,
              auto_resize = true,
              start_insert = false,
              focus = false,
              do_not_add_newline = false,
            },
          },
        },
        cmake_runner = {
          name = "terminal",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = false,
            },
            toggleterm = {
              direction = "float",
              close_on_exit = false,
              auto_scroll = true,
            },
            overseer = {
              new_task_opts = {},
              on_new_task = function(task) end,
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ",
              split_direction = "horizontal",
              split_size = 11,
              single_terminal_per_instance = true,
              single_terminal_per_tab = true,
              keep_terminal_static_location = true,
              auto_resize = true,
              start_insert = false,
              focus = false,
              do_not_add_newline = false,
            },
          },
        },
        cmake_notifications = {
          runner = { enabled = true },
          executor = { enabled = true },
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          refresh_rate_ms = 100,
        },
      })
    end,
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>ct", "<cmd>CMakeRunTest<cr>", desc = "CMake Run Tests" },
      { "<leader>cs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Select Build Type" },
      { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
      { "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake Install" },
    },
  },


  -- Header/source file switching
  {
    "jakemason/ouroboros.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "c", "cpp", "h", "hpp", "cc", "cxx" },
    config = function()
      require("ouroboros").setup({
        -- Optional: customize the extension matching weights
        extension_preferences_table = {
          c = {h = 2, hpp = 1},
          h = {c = 2, cpp = 1, cc = 1, cxx = 1},
          cpp = {hpp = 2, h = 1, hxx = 1},
          hpp = {cpp = 2, cc = 1, cxx = 1, c = 1},
          cc = {hh = 2, h = 1, hpp = 1},
          hh = {cc = 2, cpp = 1},
          cxx = {hxx = 2, h = 1, hpp = 1},
          hxx = {cxx = 2, cpp = 1},
        },
      })
    end,
    keys = {
      { "<leader>ch", "<cmd>Ouroboros<cr>", desc = "Switch between header/source" },
    },
  },

  -- Better formatting for C/C++
  {
    "rhysd/vim-clang-format",
    ft = { "c", "cpp", "objc", "objcpp" },
    config = function()
      vim.g.clang_format_style = "file"
      vim.g.clang_format_fallback_style = "llvm"
    end,
    keys = {
      { "<leader>cf", "<cmd>ClangFormat<cr>", desc = "Format with clang-format", mode = { "n", "v" } },
    },
  },

}