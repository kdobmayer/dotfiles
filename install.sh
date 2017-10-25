#!/usr/bin/env bash
#
# Create symlinks for dotfiles

set -o pipefail

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

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
  ln -s $SCRIPT_DIR/$BACKUP_DIR/"${file}" $HOME/."${file}"
done

# youtube-dl
sudo -H pip install --upgrade youtube-dl

#
# i3
#

# xkb-switch
# i3blocks
git clone https://github.com/vivien/i3blocks.git
make -C i3blocks clean all
sudo make -C i3blocks install

# compton
git clone https://github.com/chjj/compton
make
make install
# nylas mail
# https://www.nylas.com/download
