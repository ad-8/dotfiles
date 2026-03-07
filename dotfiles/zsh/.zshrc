# Lines configured by zsh-newuser-install
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ax/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

export PATH="$HOME/.config/emacs/bin:$PATH"

setopt autocd

# fixes missing nerd icons in nnn
export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

alias e='emacs -nw'
alias n="VISUAL='emacsclient -nw' nnn"
alias nf='clear && fastfetch --config neofetch && echo'
alias l='eza -l --group-directories-first --icons'
alias lll='eza -al --group-directories-first --icons'

fpath+=($HOME/.zsh/pure)

export PURE_PROMPT_SYMBOL='λ'
export PURE_CMD_MAX_EXEC_TIME=2

autoload -U promptinit; promptinit
prompt pure

source <(fzf --zsh)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
