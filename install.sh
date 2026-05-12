#!/usr/bin/env bash
set -euo pipefail

# Absolute path to this dotfiles repo (works no matter where the script is run from).
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Print usage.
usage() {
  cat <<EOF
Usage: $0 [--deps|--all]

  (no flag)   symlink configs only
  --deps      install system, npm, and pipx dependencies
  --all       both
EOF
}

# Bail loudly if not on Arch — this script is Arch-only.
require_arch() {
  if ! command -v pacman >/dev/null 2>&1; then
    echo "this installer only supports Arch (pacman not found)" >&2
    exit 1
  fi
}

# Symlink one path. Refuses to clobber a real file at the destination.
link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "skip: $dest exists and is not a symlink"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "linked: $dest -> $src"
}

# Symlink every config managed by this repo.
do_symlinks() {
  link "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
  link "$DOTFILES/.config/tmux" "$HOME/.config/tmux"
}

# Arch system packages. --needed skips already-installed.
install_arch() {
  sudo pacman -S --needed --noconfirm \
    fzf ripgrep fd tmux \
    nodejs npm \
    python python-pipx \
    lua-language-server stylua \
    git base-devel curl
}

# Global npm packages — LSP servers and prettier.
install_npm_globals() {
  npm install -g \
    @vtsls/language-server \
    @tailwindcss/language-server \
    @astrojs/language-server \
    yaml-language-server \
    dockerfile-language-server-nodejs \
    vscode-langservers-extracted \
    prettier
}

# Python LSP / lint tools, isolated from system Python via pipx.
install_pipx_packages() {
  pipx ensurepath >/dev/null
  for pkg in basedpyright ruff; do
    if pipx list --short 2>/dev/null | awk '{print $1}' | grep -qx "$pkg"; then
      echo "pipx: $pkg already installed"
    else
      pipx install "$pkg"
    fi
  done
}

# Full dependency install (Arch only).
do_deps() {
  require_arch
  install_arch
  install_npm_globals
  install_pipx_packages
}

# Dispatch on flag.
case "${1:-}" in
  "")        do_symlinks ;;
  --deps)    do_deps ;;
  --all)     do_symlinks; do_deps ;;
  -h|--help) usage ;;
  *)         usage; exit 1 ;;
esac
