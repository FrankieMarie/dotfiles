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

# Pick the host's package manager. Bails on unsupported distros.
detect_distro() {
  if command -v pacman >/dev/null 2>&1; then echo arch
  elif command -v apt-get >/dev/null 2>&1; then echo debian
  else echo "unsupported distro" >&2; exit 1
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
    lua-language-server \
    git base-devel curl
}

# Debian/Ubuntu system packages. lua-language-server isn't reliably packaged, so we grab the latest release below.
install_debian() {
  sudo apt-get update
  sudo apt-get install -y \
    fzf ripgrep fd-find tmux \
    nodejs npm \
    python3 python3-pip pipx \
    git build-essential curl
  install_lua_ls_from_release
}

# Download latest lua-language-server release into ~/.local for distros that don't package it.
install_lua_ls_from_release() {
  local bin="$HOME/.local/bin/lua-language-server"
  if [ -x "$bin" ]; then echo "lua-language-server: already installed"; return; fi

  # Resolve the latest release tag from GitHub's API.
  local version
  version=$(curl -fsSL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest \
    | grep '"tag_name":' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
  echo "lua-language-server: installing $version"

  local dir="$HOME/.local/share/lua-language-server"
  mkdir -p "$dir" "$HOME/.local/bin"
  curl -fsSL "https://github.com/LuaLS/lua-language-server/releases/download/${version}/lua-language-server-${version}-linux-x64.tar.gz" \
    | tar -xz -C "$dir"
  ln -sf "$dir/bin/lua-language-server" "$bin"
  echo "lua-language-server: installed (ensure ~/.local/bin is on PATH)"
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

# Full dependency install for the detected distro.
do_deps() {
  case "$(detect_distro)" in
    arch)   install_arch ;;
    debian) install_debian ;;
  esac
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
