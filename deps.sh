#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "deps only supported on Arch (pacman not found)" >&2
  exit 1
fi

# Arch system packages. --needed skips already-installed.
sudo pacman -S --needed --noconfirm \
  stow \
  fzf ripgrep fd tmux starship \
  nodejs npm \
  python python-pipx \
  lua-language-server stylua \
  shellcheck shfmt \
  git base-devel curl

# Global npm packages — LSP servers and prettier.
npm install -g \
  @vtsls/language-server \
  @tailwindcss/language-server \
  @astrojs/language-server \
  yaml-language-server \
  dockerfile-language-server-nodejs \
  vscode-langservers-extracted \
  bash-language-server \
  tree-sitter-cli \
  prettier

# Python LSP / lint tools, isolated from system Python via pipx.
pipx ensurepath >/dev/null
pipx install basedpyright
pipx install ruff
