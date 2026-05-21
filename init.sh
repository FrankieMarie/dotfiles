#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$DOTFILES/deps.sh"
"$DOTFILES/link.sh"
