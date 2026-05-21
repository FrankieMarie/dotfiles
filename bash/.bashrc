# Interactive-only — skip when ssh/scp invoke a non-interactive shell.
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"

# Big history, dedupe, append after each command so concurrent shells don't clobber each other.
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth
shopt -s histappend
PROMPT_COMMAND='history -a'

shopt -s checkwinsize    # resize lines/cols after each command
shopt -s globstar        # ** matches recursively
shopt -s autocd          # type a dir name to cd into it

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vi='nvim'
alias ..='cd ..'
alias ...='cd ../..'

if command -v dircolors >/dev/null 2>&1; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# Programmable completion for git/systemctl/etc.
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# fnm — node version manager
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell bash)"
fi

# Guarded so a missing binary doesn't break shell startup on a fresh machine.
command -v starship >/dev/null && eval "$(starship init bash)"
command -v fzf >/dev/null && eval "$(fzf --bash)"

# Per-host overrides (gitignored, untracked — for WSL-specific vars etc.)
[ -f ~/.bashrc.local ] && source ~/.bashrc.local || true
