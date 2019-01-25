# Dotfiles

## Easiest Setup

To get this working on your system (assuming Ubuntu) do the following:

```bash
sudo apt install git stow -y
git clone https://github.com/cooperpellaton/dotfiles.git
cd dotfiles
stow tmux
stow bash
stow ssh
stow vim
stow themes
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
            uzbl/
                .config/
                    uzbl/
                        [...some files]
                .local/
                    share/
                        uzbl/
                            [...some files]
            vim/
                .vim/
                    [...some files]
                .vimrc
```

and to get these files to be used by our system we'll do the following:

```bash
$ cd ~/dotfiles
$ stow bash
$ stow uzbl
$ stow vim
```

This will create a symbolic link for every file in each of those folders into our root directory, thus allowing us to use the configuration files.