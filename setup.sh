#!/bin/bash
# file: setup.sh

# This is a setup script for my dotfiles. This *must* be run with `sudo`!

# Check to make sure we're being run as root, if not we exit.
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# Install some platform tools. This will vary based on my development, but in general I want:
#	* C
#	* Java
# 	* Python
#	* Rust
sudo apt update && sudo apt upgrade -y
sudo apt install default-jdk python-dev cmake gcc g++ nodejs npm curl -y
sudo npm install -g tldr
echo "The Rust install will take some time. Don't worry if it hangs.\n"
curl https://sh.rustup.rs -sSf | sh

# Now move on to dotfile configuration.
cd ~

# Install all the files programs and themes, etc. that we want.
sudo apt install git stow tmux neovim ranger fonts-powerline fish python3-dev python3-pip python3-setuptools htop -y
sudo pip3 install thefuck
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/cooperpellaton/dotfiles.git
wget https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
sudo dpkg -i bat_0.10.0_amd64.deb
rm bat_0.10.0_amd64.deb

# Install TLDR
npm install -g TLDR

# Install Anaconda for Python 3.7
cd /tmp/
curl -O https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
chmod +x Anaconda3-2018.12-Linux-x86_64.sh
./Anaconda3-2018.12-Linux-x86_64.sh

# Now unpack the configuration files for our programs.
cd dotfiles
stow tmux
rm ~/.bashrc
stow bash
stow ssh
stow nvim
stow vim
stow fish
vim +PluginInstall +qall

# Setup YCM.
cd ~/.vim/bundle/youcompleteme/  
python install.py --clang-completer --java-completer --ts-completer

# Configure git.
git config --global user.email "cooper@cooperpellaton.com"
git config --global user.name "Cooper Pellaton"

# We don't do this anymore because to maintain compatability with Bash on Ubuntus on Windows, we need to launch fish
# from within the .bashrc. This is so that our colors load properly and we can load TMUX.
	# Make our default shell `fish`.
	# echo /usr/bin/fish | sudo tee -a /etc/shells
	# chsh -s /usr/bin/fish

# Let's bootstrap the fish configuration script.
cd ~/dotfiles/
chmod +x setup.fish
fish ./setup.fish
