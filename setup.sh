#!/bin/bash
# file: setup.sh

# This *must* be run with `sudo` since we're going to call out to `apt`.
# Check to make sure we're being run as root, if not we exit.
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root!"
	exit
fi

# Install some platform tools.
sudo apt update && sudo apt install -yq  \
	git stow tmux neovim fish ripgrep bat fzf feh

# Non-package-manager managed dependencies.
delta_version=0.12.1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -O https://github.com/dandavison/delta/releases/download/$delta_version/git-delta_${delta_version}_amd64.deb && sudo dpkg -i git-delta_${delta_version}_amd64.deb

# Now move on to dotfile configuration.
git clone https://github.com/cooperpellaton/dotfiles.git ~/dotfiles

# Now unpack the configuration files for our programs.
cd ~/dotfiles/ || exit
stow -t /home/$USER */

# We did this all with `sudo` so we need to change permissions.
sudo chown -R "$USER": ~/.config

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
sudo chsh -s /usr/bin/fish

# Let's bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
