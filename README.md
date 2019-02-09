# Dotfiles

## Easiest Setup

To get these files up and working on your system (assuming Ubuntu) do the following:

```bash
sudo apt install git stow tmux neovim ranger -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/cooperpellaton/dotfiles.git
cd dotfiles
stow tmux
stow bash
stow ssh
stow vim
stow themes
vim +PluginInstall +qall
# stow any other folders that might be useful
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
```

This will create a symbolic link for every file in each of those folders into our root directory, thus allowing us to use the configuration files.
