#!/usr/bin/fish
# file: fish.sh

# Install OMF
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Install fish plugins
omf install https://github.com/evanlucas/fish-kubectl-completions
omf install https://github.com/jorgebucaran/fish-nvm
omf reload
echo "Fish plugins installed!";
