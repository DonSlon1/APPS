#!/bin/bash

echo "Installing optional Neovim providers..."
echo "======================================="

# Node.js provider
echo "Installing Node.js provider..."
npm install -g neovim

# Python provider
echo "Installing Python provider..."
pip install --user pynvim

# Ruby provider
echo "Installing Ruby provider..."
gem install neovim

# Perl provider (optional, less commonly used)
echo "Installing Perl provider (optional)..."
cpanm Neovim::Ext || echo "Perl provider installation failed (optional)"

echo ""
echo "Installation complete!"
echo "Restart Neovim and run :checkhealth to verify."