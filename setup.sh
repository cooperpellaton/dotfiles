#!/usr/bin/env bash

# Unpack the configuration files for our programs.
stow fish bat git nvim tmux

# Configure git.
git config --global user.email "c@cepp.ch"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
chsh -s /usr/bin/fish

# Ensure we can find `fortune` on the path
fish -c "fish_add_path /usr/games"

# Install fisher to manage fish shell dependencies.
FISHER_INSTALL_LOCATION=$HOME/.config/fish/functions/fisher.fish
if [[ ! -d $FISHER_INSTALL_LOCATION ]]; then
    # Install fish plugins
    echo "Installing fisher!"
    fish -c "curl -sL git.io/fisher | source && fisher update"
    echo "Fish plugins installed!"
fi