#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=de_DE.UTF-8
#export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] $"

export EDITOR=vim

export PYTHON24=/usr/bin/python2.4
export PYTHON25=/usr/bin/python2.5
#export PYTHON26=/usr/bin/python2.6
export PYTHON27=/usr/bin/python2.7

#Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# listings
alias ls='ls -G'
alias la="ls -la"
alias ll="ls -lah"
alias l="ls -lah"
alias lh='ls -lah'                # human readable (sizes) long and all ;-)
alias lls='ls -l -h -g -F -G'
alias lc='ls -aCF'
alias lsam='ls -am'               # List files horizontally
alias lr='ls -lR'                 # recursive
alias lsx='ls -ax'                # sort right to left rather then in columns
alias lss='ls -shaxSr'            # sort by size
alias lt='ls -latr'               # sort by date
alias lm='ls -al |more'           # pipe through 'more'
alias home='cd ~'                # go home

alias df='df -h'

# Awesome oneliner 
# green if exit status 0, red if exit status 1
# shows the python virtualenv you are working on like [2.7]
export PROMPT_COMMAND='PS1="\`if [ \$? = 0 ]; then echo "\\[\\e[95m\\]"; else echo "\\[\\e[93m\\]"; fi\`\`echo ${VIRTUAL_ENV:+[${VIRTUAL_ENV##*/}]}\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 30 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'
