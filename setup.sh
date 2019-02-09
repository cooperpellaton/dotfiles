#!/bin/bash
# file: setup.sh

# This is a setup script for my dotfiles. This *must* be run with `sudo`!

cd ~

# Install all the files programs and themes, etc. that we want.
sudo apt install git stow tmux neovim ranger fonts-powerline -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/cooperpellaton/dotfiles.git
wget https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
sudo dpkg -i bat_0.10.0_amd64.deb
rm bat_0.10.0_amd64.deb

# Now unpack the configuration files for our programs.
cd dotfiles
stow tmux
stow bash
stow ssh
stow nvim
stow vim
stow themes
vim +PluginInstall +qall

echo "All files and programs have been installed!\m"
