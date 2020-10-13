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
	default-jdk \
	cmake \
	gcc \
	g++ \
	curl \
	wget \
	git \
	stow \
	tmux \
	neovim \
	fish \
	ripgrep \
	htop

# Now move on to dotfile configuration.
cd ~

# Install all the files programs and themes, etc. that we want.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/cooperpellaton/dotfiles.git
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb
sudo dpkg -i bat_0.10.0_amd64.deb && rm bat_0.10.0_amd64.deb

# Install Miniconda for Python 3.8
cd /tmp/ && curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# Install NVM; we can set the version later.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

# We did this all with `sudo` so we need to change permissions.
chown $USER: ~/.tmux/
chown $USER: ~/.vim/

# Now unpack the configuration files for our programs.
cd ~/dotfiles/
rm ~/.bashrc && stow bash
stow ssh
stow nvim
rm ~/.vimrc && stow vim
stow fish
vim +PluginInstall +qall

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
chsh -s $(which fish)

# Let's bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
