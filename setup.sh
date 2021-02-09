#!/bin/bash
# file: setup.sh

# This *must* be run with `sudo` since we're going to call out to `apt`.
# Check to make sure we're being run as root, if not we exit.
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root!"
	exit
fi

# Install some platform tools.
sudo apt update && sudo apt install -yq --no-install-recommends \
	git stow tmux neovim fish ripgrep bat fzf

# Non-package-manager managed dependencies.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# Now move on to dotfile configuration.
git clone https://github.com/cooperpellaton/dotfiles.git ~/dotfiles

# Now unpack the configuration files for our programs.
cd ~/dotfiles/ || exit
stow nvim
rm ~/.vimrc && stow vim
stow fish
vim +PluginInstall +qall

# We did this all with `sudo` so we need to change permissions.
sudo chown -R "$USER": ~/.tmux/
sudo chown -R "$USER": ~/.vim/

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
sudo chsh -s "$(which fish)"

# Let's bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
