#!/bin/bash

# Install ElixirLS for Neovim
echo "Installing ElixirLS..."

# Install Elixir and Erlang if not present
if ! command -v elixir &> /dev/null; then
    echo "Installing Elixir and Erlang..."
    sudo pacman -S elixir erlang --noconfirm
fi

# Create directory for ElixirLS in user's home
mkdir -p ~/.local/share/elixir-ls

# Download and install ElixirLS
cd /tmp
wget https://github.com/elixir-lsp/elixir-ls/releases/download/v0.24.1/elixir-ls-v0.24.1.zip
unzip -o elixir-ls-v0.24.1.zip -d ~/.local/share/elixir-ls/
chmod +x ~/.local/share/elixir-ls/*.sh

# Clean up
rm elixir-ls-v0.24.1.zip

echo "ElixirLS installed successfully in ~/.local/share/elixir-ls/"
echo "You can now use Elixir LSP in Neovim"