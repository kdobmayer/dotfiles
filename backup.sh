#!/usr/bin/env bash
#
# Collect dotfiles for tmux, vim and zsh

set -o pipefail

DOTFILES=(
    alacritty.yml
    ansible.cfg
    tmux.conf
    vimrc
    zprofile
    zshrc
)

BACKUP_DIR=dotfiles
BOOKMARK=$HOME/.config/vivaldi/Default/Bookmarks

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&2
}

main() {
  for dotfile in "${DOTFILES[@]}"; do
    local file=$HOME/.${dotfile}
    if [[ ! -f "${file}" ]]; then
      err "The file ${file} doesn't exist"
      continue
    fi

    local current_dir=$(dirname $(readlink -f "$0"))
    local copied=$(cp -uv "${file}" "${current_dir}/${BACKUP_DIR}/${dotfile}")
    if [[ -n "${copied}" ]]; then
      printf "backed up %s\n" "${file}"
    fi
  done
}

main "$@"
