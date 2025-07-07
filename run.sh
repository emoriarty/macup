#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"
                                   
   ____ ___  ____ ________  ______ 
  / __ `__ \/ __ `/ ___/ / / / __ \
 / / / / / / /_/ / /__/ /_/ / /_/ /  
/_/ /_/ /_/\__,_/\___/\__,_/ .___/ 
                          /_/      

EOF
}

# Clear the terminal and print the logo
clear
print_logo

# Exit on any error
set -e

# Install homebrew if not present
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Source the package list
if [ ! -f "utils.sh" ]; then
  echo "Error: utils.sh not found!"
  exit 1
fi

source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Upgrade Homebrew packages
echo "Upgrading Homebrew packages..."
brew upgrade

# Install packages
echo "Installing packages..."
install_package "${SYSTEM_UTILS[@]}"
install_package "${DEV_TOOLS[@]}"

# Clean up Homebrew
echo "Cleaning up Homebrew..."
brew cleanup
