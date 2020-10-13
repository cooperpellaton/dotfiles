#!/usr/local/bin/fish
# file: setup.fish

# Install OMF
if test -d ~/.config/omf
    echo "OMF already installed."
else
    echo "Installing oh-my-fish!"
    curl -L https://get.oh-my.fish | fish
end

# Install fish plugins
set -l plugins fish-kubectl-completions fish-docker-compose fish-nvm bass eclm fish-spec fzf google-cloud-sdk-fish-completion
for plug in $plugins
    omf install $plug
end
echo "Fish plugins installed!"

# Reload the shell for changes to take effect.
omf reload
