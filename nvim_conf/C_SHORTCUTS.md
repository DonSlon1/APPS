# Neovim C/C++ Development Shortcuts

## Quick Compile & Run
- `F6` - Compile and run current file
- `F7` - Compile only
- `F8` - Run compiled executable

## Debugging (DAP)
### Control Flow
- `F5` - Start/Continue debugging
- `F10` - Step over
- `F11` - Step into
- `F12` - Step out

### Breakpoints
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint
- `<leader>dl` - Set log point
- `<leader>dC` - Clear all breakpoints
- `<leader>dL` - List breakpoints

### Debug UI & Session
- `<leader>du` - Toggle debug UI
- `<leader>dr` - Open REPL
- `<leader>dR` - Run last debug session
- `<leader>dt` - Terminate debug session
- `<leader>ds` - Show debug session
- `<leader>dp` - Pause execution
- `<leader>dc` - Run to cursor

### Debug Inspection
- `<leader>de` - Evaluate expression (normal/visual mode)
- `<leader>dE` - Evaluate custom expression
- `<leader>dh` - Hover variables
- `<leader>dS` - Show scopes
- `<leader>df` - Float debug element

## LSP Features
### Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show references
- `gt` - Go to type definition
- `K` - Show hover documentation
- `<C-k>` - Show signature help

### Code Actions
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action (normal/visual)
- `<leader>f` - Format buffer/selection

### Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>e` - Show diagnostic float
- `<leader>q` - Send diagnostics to loclist

### Workspace
- `<leader>wa` - Add workspace folder
- `<leader>wr` - Remove workspace folder
- `<leader>wl` - List workspace folders

### Clangd Specific
- `<leader>cs` - Switch source/header (LSP method)
- `<leader>ch` - Switch source/header (Ouroboros plugin)
- `<leader>ct` - Show type hierarchy
- `<leader>cm` - Show memory usage
- `<leader>ci` - Show symbol info
- `<leader>ih` - Toggle inlay hints

## CMake Integration
- `<leader>cg` - Generate CMake project
- `<leader>cb` - Build with CMake
- `<leader>cr` - Run CMake target
- `<leader>cd` - Debug CMake target
- `<leader>ct` - Run CMake tests
- `<leader>cs` - Select build type
- `<leader>cc` - Clean CMake build
- `<leader>ci` - Install CMake project

## Formatting
- `<leader>cf` - Format with clang-format (normal/visual)

## File Navigation
- `<leader>ch` - Switch between header/source files

## Additional Tips
### Compilation Flags
- Default C compile: `gcc -Wall -Wextra -g`
- Default C++ compile: `g++ -std=c++17 -Wall -Wextra -g`

### Man Pages
- `K` - Open man page for word under cursor (in C/C++ files)

### Auto Features
- Auto header guards for new `.h`/`.hpp` files
- Auto-completion with clangd
- Syntax checking and diagnostics
- Inlay hints for parameters and types

### Prerequisites
System packages needed:
```bash
# Ubuntu/Debian
sudo apt install clangd gdb lldb cmake clang-format build-essential

# Arch Linux
sudo pacman -S clang gdb lldb cmake

# macOS
brew install llvm cmake
```

### First Time Setup
1. Open Neovim
2. Run `:Lazy sync` to install all plugins
3. Run `:Mason` to check LSP server installation
4. Open a C file - clangd will auto-install if needed

### Project Setup Tips
1. For best LSP experience, generate `compile_commands.json`:
   ```bash
   # With CMake
   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .

   # With Bear (for Make projects)
   bear -- make
   ```

2. Create `.clang-format` for project-specific formatting

3. Create `.clang-tidy` for additional checks

### Troubleshooting
- If LSP not working: `:LspInfo` to check status
- If debugging fails: Check gdb/lldb installation
- For CMake projects: Ensure CMakeLists.txt exists