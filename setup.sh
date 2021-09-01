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
	git stow tmux neovim fish ripgrep bat fzf feh

# Non-package-manager managed dependencies.
nvm_version=v0.38.0
delta_version=0.8.3
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh | bash
curl -O https://github.com/dandavison/delta/releases/download/$delta_version/git-delta_${delta_version}_amd64.deb && sudo dpkg -i git-delta_0.8.3_amd64.deb

# Now move on to dotfile configuration.
git clone https://github.com/cooperpellaton/dotfiles.git ~/dotfiles

# Now unpack the configuration files for our programs.
cd ~/dotfiles/ || exit
stow nvim
stow fish
vim +PlugInstall +qall

# We did this all with `sudo` so we need to change permissions.
sudo chown -R "$USER": ~/.config

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
sudo chsh -s "$(which fish)"

# Let's bootstrap the fish configuration script.
chmod +x setup.fish && fish ./setup.fish
