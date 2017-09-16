#!/usr/bin/env bash
#
# Create symlinks for dotfiles

set -o pipefail

CURRENT_DIR=$(dirname $(readlink -f "$0"))
BACKUP_DIR=dotfiles

# Packages
pacman -Syu curl git tmux vim xcape zsh
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
  file=$(basename "${dotfile}")
  ln -s $CURRENT_DIR/$BACKUP_DIR/"${file}" $HOME/."${file}"
done

# youtube-dl
sudo -H pip install --upgrade youtube-dl
