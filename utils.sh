#!/bin/bash

function is_installed() {
  # check with brew if a package is installed
  local package="$1"
  if brew list --formula | grep -q "^$package\$"; then
    return 0  # Package is installed
  else
    return 1  # Package is not installed
  fi
}

function is_cask_installed() {
  # check with brew if a cask is installed
  local cask="$1"
  if brew list --cask | grep -q "^$cask\$"; then
    return 0  # Cask is installed
  else
    return 1  # Cask is not installed
  fi
}


# Function to install packages if not already installed
function install_package() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing packages: ${to_install[*]}"
    brew install "${to_install[@]}"
  fi
}

# Function to install cask packages if not already installed
function install_cask() {
  local casks=("$@")
  local to_install=()

  for cask in "${casks[@]}"; do
    if ! is_cask_installed "$cask"; then
      to_install+=("$cask")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing casks: ${to_install[*]}"
    brew install --cask "${to_install[@]}"
  fi
}
