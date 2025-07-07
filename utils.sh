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
