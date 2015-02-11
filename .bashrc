# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM="xterm-color"

# source my own .dir_colors file
if [ -f $HOME/.dir_colors ]
then
 eval `dircolors -b $HOME/.dir_colors`
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=de_DE.UTF-8
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

export PYTHON25=/usr/local/bin/python2.5
export PYTHON26=/usr/local/bin/python2.6
export PYTHON27=/usr/bin/python
export PYTHONDONTWRITEBYTECODE=1

export GIT_SSL_NO_VERIFY=true

export JAVA_HOME="/opt/java"

#Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

set_prompt () {
    LAST_CMD=$?
    BLUE='\[\e[0;94m\]'
    RED='\[\e[0;31m\]'
    RESET='\[\e[00m\]'
    if [ $LAST_CMD -eq 0 ]; then
        PS1=$BLUE
    else
        PS1=$RED
    fi
    PS1+=${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}
    PS1+=$(__git_ps1)
    PS1+='\[\u@\h:'
    if [ $(pwd | wc -c) -ge 31 ]; then
        PS1+='\W'
    else
        PS1+='\w'
    fi
    PS1+='\]\$ '
    PS1+=$RESET
}
PROMPT_COMMAND='set_prompt'
#old prompt
#export PROMPT_COMMAND='PS1="\`if [ \$? = 0 ]; then echo "\\[\\e[94m\\]"; else echo "\\[\\e[31m\\]"; fi\`\`echo ${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}\`$(__git_ps1)\[\u@\h:\`if [[ `pwd|wc -c|tr -d " "` > 30 ]]; then echo "\\W"; else echo "\\w";fi\`\]\$\[\033[0m\] "; echo -ne "\033]0;`hostname`:`pwd`\007"'

PATH=$PATH:/opt/java/bin # java path
