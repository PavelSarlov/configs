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
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/psarlov/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/psarlov/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/psarlov/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/psarlov/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda deactivate
# <<< conda initialize <<<

