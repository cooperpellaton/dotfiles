# Dotfiles

## Overview

To get these files up and working on your system (assuming Ubuntu/Debian) run the [`setup.sh`](setup.sh) script which will install all the packages and even configure [fish](https://fishshell.com/) using [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish).

## Installation

```bash
git clone https://github.com/cooperpellaton/dotfiles.git ~/dotfiles && sudo bash ~/dotfiles/setup.sh
```

## Explanation

This repo will bootstrap itself with the necessary programs to configure a computer to my liking. To store files I use [GNU Stow](https://www.gnu.org/software/stow/) to symlink config files from this directory into the home folder. This [resource](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) explains how this actually works; the repo has a structure like this:

```text
.
├── .git
├── .gitignore
├── .gitmodules
├── Brewfile
├── README.md
├── bat
│   └── .config
│       └── bat
│           └── config
├── emacs
│   ├── .emacs
│   └── .emacs.d
├── fish
│   └── .config
│       └── fish
│           ├── completions
│           ├── conf.d
│           │   ├── br.fish -> /Users/cooperpellaton/Library/Application\ Support/org.dystroy.broot/launcher/fish/1.fish
│           │   └── omf.fish
│           ├── config.fish
│           ├── fish_variables
│           └── functions
│               ├── fish_prompt.fish -> /Users/cooperpellaton/.local/share/omf/themes/eclm/fish_prompt.fish
│               └── fisher.fish
├── nvim
│   └── .config
│       └── nvim
│           ├── init.vim
│           └── spell
│               ├── en.utf-8.add
│               └── en.utf-8.add.spl
├── pbcopy
├── setup.fish
├── setup.sh
├── tmux
│   └── .tmux.conf
└── vim
    └── .vimrc
```

To get these files to be used by our system the script will do the following:

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
* [Awesome Tmux](https://github.com/rothgar/awesome-tmux)
