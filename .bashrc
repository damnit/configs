# ~/.bashrc
if [ -v TMUX ]
then
    export TERM='screen-256color'
else
    if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
    else
        export TERM='xterm-color'
    fi
fi

# source my own .dir_colors file
if [ -f $HOME/.dir_colors ]
then
 eval `dircolors -b $HOME/.dir_colors`
fi

# bind up and down keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=de_DE.UTF-8
export GIT_SSL_NO_VERIFY=true
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWUPSTREAM="auto git"

# Aliases
alias df='df -h'
alias ls='ls -GA --color=auto'
alias la="ls -la --color=auto"
alias ll="ls -lah --color=auto"
alias l="ls -lah --color=auto"
alias grep="grep --color=auto"
alias doch='su -c "$(history -p !-1)"'
alias fuck_ds_store='find . -name .DS_Store -exec rm {} \; && find . -name ._.DS_Store -exec rm {} \;'
alias fuck_pyc='find . -name "*.pyc" -exec rm {} \;'
alias htmltidy='tidy -mi -xml -wrap 0'
alias tmux='tmux -2'
alias gst='git status'
alias git_checkout_changed='git status | grep geändert | cut -d ":" -f2 | xargs git checkout'
grep_and_vim () {
    vim $(grep -RIn "$1" | cut -d ":" -f 1 | sort -u | grep "$2")
}
alias grim=grep_and_vim
alias vim=nvim

export EDITOR=nvim
export MANPAGER="vim -M +MANPAGER --not-a-term -"
export PYTHONDONTWRITEBYTECODE=1

PATH=$PATH:$HOME/.poetry/bin

#Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source ~/.local/share/git-prompt.sh
source ~/.local/share/git-completion.bash
source ~/.local/share/poetry-completion.bash
shopt -s checkwinsize

set_prompt () {
    LAST_CMD=$?
    PS1=''
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    local RED="\[$(tput setaf 1)\]"
    local GREEN="\[$(tput setaf 2)\]"
    local YELLOW="\[$(tput setaf 3)\]"
    local BLUE="\[$(tput setaf 4)\]"
    local PURPLE="\[$(tput setaf 5)\]"
    local CYAN="\[$(tput setaf 6)\]"
    local RESET="\[$(tput sgr0)\]"
    # Nice cyan colored python virtualenv tag
    PS1+=$PURPLE${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}
    # Yellow default __git_ps1
    PS1+=$YELLOW$(__git_ps1)$RESET
    ## color red if last exit code is nonzero
    # ' user@host: '
    [[ $LAST_CMD -eq 0 ]] && PS1+=$CYAN || PS1+=$RED
    PS1+=' [\u@\h '
    [[ $(pwd | wc -c) -ge 31 ]] && PS1+='\W' || PS1+='\w'
    PS1+='] '$RESET
}

PROMPT_COMMAND='set_prompt'

# thanks http://blog.no-panic.at/2015/04/21/set-tmux-pane-title-on-ssh-connections/
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

eval "$(starship init bash)"
if [ ! -S ~/.auth_sock_ssh ]; then
  eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" ~/.auth_sock_ssh
fi
export SSH_AUTH_SOCK=~/.auth_sock_ssh
ssh-add -l > /dev/null || ssh-add
