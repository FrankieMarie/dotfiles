# dotfiles

Personal config managed with [GNU stow](https://www.gnu.org/software/stow/) — one stow package per tool, symlinked into `$HOME`.

## Prereqs

- **`sudo`** access (only for the deps step).
- **`git`** to clone this repo.
- **A [Nerd Font](https://www.nerdfonts.com/)** installed and selected in your terminal — starship, tmux, and the nvim status line all use Nerd Font glyphs.
- **Arch or Debian.** Both have an automatic dependency path; anything else skips deps with a warning and only symlinks (see [Debian](#debian) below).

## Setup

```bash
git clone git@github.com:FrankieMarie/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` installs dependencies (distro packages, global npm packages under `~/.local`, pipx tools — read the script for the canonical list), then stows packages via an fzf picker (tab to multi-select, enter to confirm).

Flags:

| Flag        | Effect                                          |
| ----------- | ----------------------------------------------- |
| `--arch`    | force the pacman path                           |
| `--deb`     | force the apt path                              |
| `--no-deps` | skip dependency installation, only stow         |
| `--all`     | stow every package, no picker                   |

Distro is auto-detected from `pacman`/`apt-get`; the flags only matter if detection guesses wrong.

Anything neither repo carries is printed as an `install by hand:` list at the end rather than installed silently.

The picker is skipped automatically when stdin isn't a TTY or `fzf` is missing, in which case every package is stowed.

If any tracked target already exists as a real file (e.g. a pre-existing `~/.gitconfig`), `stow` will refuse to overwrite it — remove it first, then re-run.

## Packages

| Package    | Stows into                              |
| ---------- | --------------------------------------- |
| `bash`     | `~/.bashrc`, `~/.inputrc`, `~/.dircolors` |
| `claude`   | `~/.claude/skills/`                     |
| `herdr`    | `~/.config/herdr/`                      |
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

`./install.sh --deb` (or plain `./install.sh`, which auto-detects) uses apt. Differences from the Arch path:

- **Neovim comes from the official GitHub release tarball, not apt.** The config uses `vim.pack`, which needs Neovim 0.12+; Debian ships 0.7–0.9, which cannot load it at all. The script resolves the latest stable tag, unpacks it to `~/.local/nvim-<tag>`, and symlinks `~/.local/bin/nvim`. Already-current versions are skipped.
- **More tools come from npm**, since apt has no package for them: the bash, tailwind, yaml, and dockerfile language servers, plus prettier and tree-sitter-cli. Arch gets these from pacman.
- **`fzf` and `shfmt`** are best-effort — older releases lack them, and a miss is reported instead of aborting the run.
- **`starship`, `gh`, `lua-language-server`, and `stylua`** have no apt package and are listed for manual install at the end. `starship`'s official installer pipes a remote script to `sh`, so the script prints the command rather than running it for you.

Everything installs under `~/.local`, so no `sudo` is needed beyond the apt step.
