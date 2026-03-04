#!/bin/bash

echo "Installing TypeScript parsers for Neovim..."
nvim --headless -c "TSInstall typescript tsx javascript" -c "q"
echo "Done!"