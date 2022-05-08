#!/usr/local/bin/fish
# file: setup.fish

# Unpack the configuration files for our programs.
stow fish bat git nvim tmux

# Configure git.
git config --global user.email "c@cepp.ch"
git config --global user.name "Cooper Pellaton"

# Make fish the default shell.
chsh -s /usr/bin/fish

# Ensure we can find `fortune` on the path
fish_add_path /usr/games

# Install fisher to manage fish shell dependencies.
if type -q fisher
    echo "Fisher already installed."
else
    # Install fish plugins
    echo "Installing fisher!"
    curl -sL git.io/fisher | source && fisher update
    echo "Fish plugins installed!"
end
