#!/usr/local/bin/fish
# file: setup.fish

# Install Fisher: https://github.com/jorgebucaran/fisher
if type -q fisher
    echo "Fisher already installed."
else
    echo "Installing oh-my-fish!"
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

# Install fish plugins
fisher update
echo "Fish plugins installed!"

# Reload the shell for changes to take effect.
# omf reload
