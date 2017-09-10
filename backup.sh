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

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&2
}

main() {
  for dotfile in "${DOTFILES[@]}"; do
    local filename=${HOME}/.${dotfile}
    if [[ -f "${filename}" ]]; then
      local copied
      if ! copied=$(cp -uv "${filename}" "./${BACKUP_DIR}/${dotfile}"); then
        err "Can't copy ${filename}..."
      elif [[ -n "${copied}" ]]; then
        printf "backed up %s\n" "${filename}"
      fi
    else
      err "${filename} does not exist"
    fi
  done
}

main "$@"
