# ~/.bashrc

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
alias ls='ls -G --color=auto'
alias la="ls -la --color=auto"
alias ll="ls -lah --color=auto"
alias l="ls -lah --color=auto"
alias doch='su -c "$(history -p !-1)"'
alias fuck_ds_store='find . -name .DS_Store -exec rm {} \; && find . -name ._.DS_Store -exec rm {} \;'
alias fuck_pyc='find . -name "*.pyc" -exec rm {} \;'
alias htmltidy='tidy -mi -xml -wrap 0'

export EDITOR=vim
export PYTHONDONTWRITEBYTECODE=1

PATH=$PATH:/opt/java/bin # java path

#Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
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

export PROMPT_COMMAND='set_prompt'
