#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cs='xclip -selection clipboard'
alias py='python'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'

PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\[\033[01;00m\]\$ '