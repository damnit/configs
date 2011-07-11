#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LANG=de_DE.UTF-8
#export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] $"

export EMAIL="Otto Hockel <hockel.otto@googlemail.com>"
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
alias tilde='cd ~'                # go home

alias df='df -h'

# Reset
Color_Off='\e[0m'       # Text Reset

export PROMPT_COMMAND='PS1="\`if [ \$? = 0 ]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`\`echo ${VIRTUAL_ENV:+[${VIRTUAL_ENV: -3}]}\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 30 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

#########################################################
# NOT USED YET, PREPARING AWESOME COLORED PROMPT ACTION #
#########################################################

## Regular Colors
#Black='\e[0;30m'        # Black
#Red='\e[0;31m'          # Red
#Green='\e[0;32m'        # Green
#Yellow='\e[0;33m'       # Yellow
#Blue='\e[0;34m'         # Blue
#Purple='\e[0;35m'       # Purple
#Cyan='\e[0;36m'         # Cyan
#White='\e[0;37m'        # White

## Bold
#BBlack='\e[1;30m'       # Black
#BRed='\e[1;31m'         # Red
#BGreen='\e[1;32m'       # Green
#BYellow='\e[1;33m'      # Yellow
#BBlue='\e[1;34m'        # Blue
#BPurple='\e[1;35m'      # Purple
#BCyan='\e[1;36m'        # Cyan
#BWhite='\e[1;37m'       # White

## Underline
#UBlack='\e[4;30m'       # Black
#URed='\e[4;31m'         # Red
#UGreen='\e[4;32m'       # Green
#UYellow='\e[4;33m'      # Yellow
#UBlue='\e[4;34m'        # Blue
#UPurple='\e[4;35m'      # Purple
#UCyan='\e[4;36m'        # Cyan
#UWhite='\e[4;37m'       # White

## Background
#On_Black='\e[40m'       # Black
#On_Red='\e[41m'         # Red
#On_Green='\e[42m'       # Green
#On_Yellow='\e[43m'      # Yellow
#On_Blue='\e[44m'        # Blue
#On_Purple='\e[45m'      # Purple
#On_Cyan='\e[46m'        # Cyan
#On_White='\e[47m'       # White

## High Intensty
#IBlack='\e[0;90m'       # Black
#IRed='\e[0;91m'         # Red
#IGreen='\e[0;92m'       # Green
#IYellow='\e[0;93m'      # Yellow
#IBlue='\e[0;94m'        # Blue
#IPurple='\e[0;95m'      # Purple
#ICyan='\e[0;96m'        # Cyan
#IWhite='\e[0;97m'       # White

## Bold High Intensty
#BIBlack='\e[1;90m'      # Black
#BIRed='\e[1;91m'        # Red
#BIGreen='\e[1;92m'      # Green
#BIYellow='\e[1;93m'     # Yellow
#BIBlue='\e[1;94m'       # Blue
#BIPurple='\e[1;95m'     # Purple
#BICyan='\e[1;96m'       # Cyan
#BIWhite='\e[1;97m'      # White

## High Intensty backgrounds
#On_IBlack='\e[0;100m'   # Black
#On_IRed='\e[0;101m'     # Red
#On_IGreen='\e[0;102m'   # Green
#On_IYellow='\e[0;103m'  # Yellow
#On_IBlue='\e[0;104m'    # Blue
#On_IPurple='\e[10;95m'  # Purple
#On_ICyan='\e[0;106m'    # Cyan
#On_IWhite='\e[0;107m'   # White
