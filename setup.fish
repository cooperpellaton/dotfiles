#!/usr/bin/fish
# file: fish.sh

# Install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Install fish plugins
fisher add oh-my-fish/theme-batman
echo "All files and programs have been installed!";
fish
