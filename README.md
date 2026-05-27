# dotfiles

Personal config managed with [GNU stow](https://www.gnu.org/software/stow/) — one stow package per tool, symlinked into `$HOME`.

## Prereqs

Install these before running `init.sh`:

- **Arch Linux** (WSL or bare metal). `deps.sh` uses `pacman`; on Debian you install equivalents by hand (see [Debian](#debian) below).
- **`sudo`** access.
- **`git`** to clone this repo.
- **A [Nerd Font](https://www.nerdfonts.com/)** installed and selected in your terminal — starship, tmux, and the nvim status line all use Nerd Font glyphs.

## Setup

```bash
git clone git@github.com:FrankieMarie/dotfiles.git ~/dotfiles
cd ~/dotfiles
./init.sh
```

`init.sh` runs:

1. `deps.sh` — installs pacman packages, global npm packages, and pipx tools (see file for the canonical list).
2. `link.sh` — interactively stows packages with fzf (tab to multi-select, enter to confirm). Pipe stdin or run non-interactively to stow everything.

If any tracked target already exists as a real file (e.g. a pre-existing `~/.gitconfig`), `stow` will refuse to overwrite it — remove it first, then re-run `link.sh`.

## Packages

| Package    | Stows into                              |
| ---------- | --------------------------------------- |
| `bash`     | `~/.bashrc`, `~/.inputrc`, `~/.dircolors` |
| `git`      | `~/.gitconfig`, `~/.gitconfig-tilt`, `~/.gitignore_global` |
| `kitty`    | `~/.config/kitty/`                      |
| `nvim`     | `~/.config/nvim/`                       |
| `ripgrep`  | `~/.config/ripgrep/`                    |
| `starship` | `~/.config/starship.toml`               |
| `tmux`     | `~/.config/tmux/`                       |

## Per-host overrides

Untracked files in `$HOME` that override repo defaults on a single machine:

- `~/.bashrc.local` — sourced at the end of `.bashrc`. Machine-specific env vars (proxies, paths, etc.).
- `~/.gitconfig.local` — included by `.gitconfig`. Use for the WSL credential helper, host-specific signing, etc.

## pnpm via corepack

If you use `fnm` to manage Node, run `corepack enable` once after each `fnm install` — it sets up the `pnpm` shim in that Node version's bin dir. Corepack ships with Node, so no separate install is needed; it'll auto-fetch the version pinned in each repo's `packageManager` field.

```bash
fnm install 24
corepack enable
```

Per Node version — every new `fnm install` needs its own `corepack enable`.

## Git identity routing

Default identity is personal (`FrankieMarie / frankiemarie83@gmail.com`). Repos under `~/work/` switch to the tilt identity automatically via `[includeIf "gitdir:~/work/"]`.

## Debian

`deps.sh` bails on non-Arch hosts. Install the equivalent packages by hand (read `deps.sh` for the list), then run `./link.sh` directly.
