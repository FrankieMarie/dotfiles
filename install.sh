#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(nvim tmux starship kitty bash git ripgrep herdr claude)

WITH_DEPS=1
INTERACTIVE=1
DISTRO=auto
MANUAL=()

while [ $# -gt 0 ]; do
  case "$1" in
    --no-deps) WITH_DEPS=0 ;;
    --all) INTERACTIVE=0 ;;
    --arch) DISTRO=arch ;;
    --deb) DISTRO=deb ;;
    -h|--help)
      cat <<'USAGE'
usage: install.sh [--arch|--deb] [--no-deps] [--all]

  --arch     force the pacman dependency path
  --deb      force the apt dependency path
  --no-deps  skip dependency installation, only stow
  --all      stow every package without the fzf picker

Distro is auto-detected from pacman/apt-get when neither --arch nor --deb is given.
USAGE
      exit 0
      ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

detect_distro() {
  if command -v pacman >/dev/null 2>&1; then
    echo arch
  elif command -v apt-get >/dev/null 2>&1; then
    echo deb
  else
    echo unknown
  fi
}

npm_global() {
  npm install -g --prefix "$HOME/.local" "$@"
}

install_pipx_tools() {
  pipx ensurepath >/dev/null
  pipx install basedpyright
  pipx install ruff
}

install_deps_arch() {
  sudo pacman -S --needed --noconfirm \
    stow \
    fzf ripgrep fd tmux starship neovim \
    nodejs npm \
    python python-pipx \
    lua-language-server stylua \
    shellcheck shfmt \
    git base-devel curl github-cli \
    bash-language-server tree-sitter tree-sitter-cli \
    tailwindcss-language-server yaml-language-server \
    dockerfile-language-server prettier

  # No pacman package for these.
  npm_global \
    @vtsls/language-server \
    @astrojs/language-server \
    vscode-langservers-extracted

  install_pipx_tools
}

install_deps_deb() {
  local core=(
    build-essential curl git stow unzip
    tmux ripgrep fd-find
    python3 python3-venv pipx
    shellcheck
  )
  # Absent from older Debian releases; missing one must not abort the run.
  local optional=(fzf shfmt)

  sudo apt-get update
  sudo apt-get install -y "${core[@]}"

  local pkg
  for pkg in "${optional[@]}"; do
    sudo apt-get install -y "$pkg" || {
      echo "apt has no '$pkg' on this release — skipping" >&2
      MANUAL+=("$pkg")
    }
  done

  if ! command -v node >/dev/null 2>&1; then
    sudo apt-get install -y nodejs npm
  fi

  install_nvim_release

  # apt carries none of these; Arch gets them from pacman.
  npm_global \
    @vtsls/language-server \
    @astrojs/language-server \
    vscode-langservers-extracted \
    bash-language-server \
    @tailwindcss/language-server \
    yaml-language-server \
    dockerfile-language-server-nodejs \
    prettier \
    tree-sitter-cli

  install_pipx_tools

  MANUAL+=(
    "starship  — curl -sS https://starship.rs/install.sh | sh"
    "gh        — https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    "lua-language-server — https://github.com/LuaLS/lua-language-server/releases"
    "stylua    — https://github.com/JohnnyMorganz/StyLua/releases"
  )
}

# Debian's apt neovim is 0.7-0.9; the config uses vim.pack, which needs 0.12+.
install_nvim_release() {
  local arch tag url dest
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) echo "no neovim release build for $(uname -m) — install it by hand" >&2; MANUAL+=("neovim"); return 0 ;;
  esac

  # Capture before parsing: piping curl straight into grep -m1 makes curl die on EPIPE.
  local json
  json=$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest) || json=""
  tag=$(printf '%s' "$json" | grep '"tag_name"' | head -1 | cut -d'"' -f4)
  [ -n "$tag" ] || { echo "could not resolve the latest neovim tag" >&2; MANUAL+=("neovim"); return 0; }

  if [ "$(nvim --version 2>/dev/null | head -1 | awk '{print $2}')" = "$tag" ]; then
    echo "neovim $tag already installed"
    return 0
  fi

  url="https://github.com/neovim/neovim/releases/download/$tag/nvim-linux-$arch.tar.gz"
  dest="$HOME/.local/nvim-$tag"

  echo "installing neovim $tag from $url"
  rm -rf "$dest"
  mkdir -p "$dest" "$HOME/.local/bin"
  curl -fsSL "$url" | tar -xz -C "$dest" --strip-components=1
  ln -sfn "$dest/bin/nvim" "$HOME/.local/bin/nvim"
}

install_deps() {
  [ "$DISTRO" = auto ] && DISTRO=$(detect_distro)

  case "$DISTRO" in
    arch) install_deps_arch ;;
    deb)  install_deps_deb ;;
    *)
      echo "no pacman or apt-get found — skipping deps, install the equivalents by hand (see README)" >&2
      return 0
      ;;
  esac
}

link() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "stow not found — rerun without --no-deps, or install stow first" >&2
    exit 1
  fi

  local selected=("${PACKAGES[@]}")

  if [ "$INTERACTIVE" = 1 ] && [ -t 0 ] && command -v fzf >/dev/null 2>&1; then
    local picked
    picked=$(printf '%s\n' "${PACKAGES[@]}" | fzf \
      --multi --reverse --height=40% \
      --prompt="packages> " \
      --header="tab to toggle, ctrl-a to select all, enter to confirm")
    [ -z "$picked" ] && { echo "no packages selected" >&2; exit 1; }
    mapfile -t selected <<<"$picked"
  fi

  stow -d "$DOTFILES" -t "$HOME" "${selected[@]}"
  printf 'stowed: %s\n' "${selected[*]}"
}

[ "$WITH_DEPS" = 1 ] && install_deps
link

if [ "${#MANUAL[@]}" -gt 0 ]; then
  printf '\ninstall by hand:\n'
  printf '  %s\n' "${MANUAL[@]}"
fi
