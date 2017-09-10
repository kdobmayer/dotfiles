#!/usr/bin/env bash
#
# Create symlinks for dotfiles

set -o pipefail

# Packages
pacman -Sy curl git tmux vim zsh
# dependencies: python python3

# Alacritty
git clone https://aur.archlinux.org/alacritty-git.git
cd alacritty-git
makepkg -isr

# Oh-my-zsh
sh -c "$(curl -fsSL
https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Symlink dotfiles
for dotfile in backups/*; do
  filename=$(basename "${dotfile}")
  ln -s/ $PWD/backups/"${filename}" $HOME/."${filename}"
done

# youtube-dl
sudo -H pip install --upgrade youtube-dl
