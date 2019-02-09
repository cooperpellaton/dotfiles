#!/bin/bash
# file: setup.sh

# This is a setup script for my dotfiles. This *must* be run with `sudo`!

cd ~
sudo apt install git stow tmux neovim ranger fonts-powerline -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/cooperpellaton/dotfiles.git
cd dotfiles
stow tmux
stow bash
stow ssh
stow nvim
stow vim
stow themes
vim +PluginInstall +qall
