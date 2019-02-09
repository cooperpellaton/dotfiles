# Dotfiles

## Easiest Setup

To get these files up and working on your system (assuming Ubuntu) run the `setup.sh` [script](setup.sh) which will install all the packages and even configure [fish](https://fishshell.com/):

```bash
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
sudo apt install default-jdk python-dev cmake gcc g++ nodejs npm -y
sudo npm install -g tldr
echo("The Rust install will take some time. Don't worry if it hangs.")
curl https://sh.rustup.rs -sSf | sh

# Now move on to dotfile configuration.
cd ~

# Install all the files programs and themes, etc. that we want.
sudo apt install git stow tmux neovim ranger fonts-powerline fish python3-dev python3-pip python3-setuptools htop -y
sudo pip3 install thefuck
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/cooperpellaton/dotfiles.git
wget https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
sudo dpkg -i bat_0.10.0_amd64.deb
rm bat_0.10.0_amd64.deb

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
python install.py --clang-completer --java-completer --ts-completer --rust-completer

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
```

## Setup

To use these files make sure that [GNU Stow](https://www.gnu.org/software/stow/) is installed on the system, and that this repository is placed on the root folder of the system.

This [resource](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) explains how this actually works, but in short this repo has a structure like this:

```text
home/
    /cooper/
        .config/
        .local/
            .share/
        dotfiles/
            bash/
                .bashrc
                .bash_profile
                .bash_logout
                .local/
                    share/
                        uzbl/
                            [...some files]
            nvim/
            	.config/
            		nvim/
            			init.vim
            fish/
            	.config/
            		fish/
            			config.fish
            vim/
                .vim/
                    [...some files]
                .vimrc
```

and to get these files to be used by our system we'll do the following:

```bash
$ cd ~/dotfiles
$ stow bash
$ stow nvim
$ stow vim
$ stow fish
```

This will create a symbolic link for every file in each of those folders into our root directory, thus allowing us to use the configuration files.

## More Plugins

For more plugins and inspiration look at:

* [Awesome Fish](https://github.com/jorgebucaran/awesome-fish)
* [Vim Awesome](https://vimawesome.com/)

