#!/usr/local/bin/fish
# file: setup.fish

# Install fisher to manage fish shell dependencies.
if type -q fisher
    echo "Fisher already installed."
else
    echo "Installing fisher!"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

# Install fish plugins
fisher update
echo "Fish plugins installed!"
