#!/bin/bash

REPO_URL="https://github.com/emoriarty/dotfiles"
REPO_NAME="dotfiles"

function is_brew_installed() {
    command -v brew &> /dev/null
}

if ! is_brew_installed; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  stow zshrc
  stow nvim
  stow tmux
  stow editorconfig
else
  echo "Failed to clone the repository."
  exit 1
fi
