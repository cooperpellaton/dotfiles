#!/bin/bash
# file: setup.sh

# If this is a Debian-based distro install dependencies.
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
	# Install some platform tools.
	apt-get update && apt-get install -yq  \
		git stow tmux neovim fish ripgrep bat fzf
fi

# Non-package-manager managed dependencies.
delta_version=0.12.1
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -O https://github.com/dandavison/delta/releases/download/$delta_version/git-delta_${delta_version}_amd64.deb && dpkg -i git-delta_${delta_version}_amd64.deb

# Now move on to dotfile configuration.
git clone https://github.com/cooperpellaton/dotfiles.git ~/dotfiles

# Now unpack the configuration files for our programs.
cd ~/dotfiles/ || exit
stow -t /home/$USER */

chown -R "$USER": ~/.config

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
chsh -s /usr/bin/fish
# Bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
