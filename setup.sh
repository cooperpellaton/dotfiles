#!/bin/bash
# file: setup.sh

# This is a setup script for my dotfiles. This *must* be run with `sudo`!

# Check to make sure we're being run as root, if not we exit.
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root!"
	exit
fi

# Install some platform tools.
sudo apt update && sudo apt install -qq \
	curl git stow tmux neovim fish ripgrep bat fzf

# Now move on to dotfile configuration.
cd ~

# Install some external programs.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install NVM; we can set the version later.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

# We did this all with `sudo` so we need to change permissions.
chown $USER: ~/.tmux/
chown $USER: ~/.vim/

# Now unpack the configuration files for our programs.
cd ~/dotfiles/
stow nvim
rm ~/.vimrc && stow vim
stow fish
vim +PluginInstall +qall

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
chsh -s $(which fish)

# Let's bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
