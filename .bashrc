# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=de_DE.UTF-8

# Aliases
alias df='df -h'
alias ls='ls -G --color=auto'
alias la="ls -la --color=auto"
alias ll="ls -lah --color=auto"
alias l="ls -lah --color=auto"
alias doch='su -c "$(history -p !-1)"'

export PYTHON25=/usr/local/bin/python2.5
export PYTHON26=/usr/local/bin/python2.6
export PYTHON27=/usr/bin/python

export GIT_SSL_NO_VERIFY=true

#Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Awesome oneliner 
# some nice color if exit status 0, yellow if exit status 1
# shows the python virtualenv you are working on like [2.7]
export PROMPT_COMMAND='PS1="\`if [ \$? = 0 ]; then echo "\\[\\e[95m\\]"; else echo "\\[\\e[93m\\]"; fi\`\`echo ${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 30 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
