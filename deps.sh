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
  git base-devel curl github-cli \
  bash-language-server tree-sitter tree-sitter-cli \
  tailwindcss-language-server yaml-language-server \
  dockerfile-language-server prettier

# Global npm packages — LSP servers not available in pacman.
sudo npm install -g \
  @vtsls/language-server \
  @astrojs/language-server \
  vscode-langservers-extracted

# Python LSP / lint tools, isolated from system Python via pipx.
pipx ensurepath >/dev/null
pipx install basedpyright
pipx install ruff

# gh CLI extensions.
gh extension install dlvhdr/gh-dash 2>/dev/null || true
