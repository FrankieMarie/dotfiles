#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ALL_PACKAGES=(nvim tmux starship kitty bash)

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found — run ./deps.sh first" >&2
  exit 1
fi

# Pick interactively when possible, fall back to all packages otherwise (CI, piped stdin).
if [ -t 0 ] && command -v fzf >/dev/null 2>&1; then
  picked=$(printf '%s\n' "${ALL_PACKAGES[@]}" | fzf \
    --multi --reverse --height=40% \
    --prompt="packages> " \
    --header="tab to toggle, ctrl-a to select all, enter to confirm")
  [ -z "$picked" ] && { echo "no packages selected" >&2; exit 1; }
  mapfile -t selected <<<"$picked"
else
  selected=("${ALL_PACKAGES[@]}")
fi

stow -d "$DOTFILES" -t "$HOME" "${selected[@]}"
