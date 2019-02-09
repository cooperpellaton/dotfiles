# Dotfiles

## Easiest Setup

To get these files up and working on your system (assuming Ubuntu) run the `setup.sh` [script](setup.sh) which will install all the packages and even configure [fish](https://fishshell.com/):

```bash
#!/bin/bash
# file: setup.sh

# This is a setup script for my dotfiles. This *must* be run with `sudo`!

cd ~

# Install all the files programs and themes, etc. that we want.
sudo apt install git stow tmux neovim ranger fonts-powerline fish python3-dev python3-pip python3-setuptools -y
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
stow bash
stow ssh
stow nvim
stow vim
stow fish
vim +PluginInstall +qall

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Make our default shell `fish`.
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

# Let's bootstrap the fish configuration script.
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

