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
    local LAST_CMD=$?
    local BLUE='$(tput setaf 4)'
    local RED='$(tput setaf 1)'
    local CYAN='$(tput setaf 6)'
    local YELLOW='$(tput setaf 3)'
    local RESET='$(tput sgr0)'
    local TITLE='\e]0;\w\a'
    # Terminal title
    PS1=$TITLE
    # Nice cyan colored python virtualenv tag
    PS1+=$CYAN${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}
    # Yellow default __git_ps1
    PS1+=$YELLOW$(__git_ps1)
    [[ $LAST_CMD -eq 0 ]] && PS1+=$BLUE || PS1+=$RED
    PS1+=' \[\u@\h:'
    [[ $(pwd | wc -c) -ge 31 ]] && PS1+='\W' || PS1+='\w'
    PS1+='\]\$ '$RESET
}
PROMPT_COMMAND='set_prompt'
#old prompt
#export PROMPT_COMMAND='PS1="\`if [ \$? = 0 ]; then echo "\\[\\e[94m\\]"; else echo "\\[\\e[31m\\]"; fi\`\`echo ${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}\`$(__git_ps1)\[\u@\h:\`if [[ `pwd|wc -c|tr -d " "` > 30 ]]; then echo "\\W"; else echo "\\w";fi\`\]\$\[\033[0m\] "; echo -ne "\033]0;`hostname`:`pwd`\007"'

PATH=$PATH:/opt/java/bin # java path
