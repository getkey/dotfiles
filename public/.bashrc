# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoredups:erasedups
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

export VISUAL="vim"
export LC_MESSAGES='en_US.UTF-8' # for CLI programs
# another language can be used for GUI programs by exporting it in ~/.xinitrc, ie export LC_MESSAGES=fr_FR.UTF-8

if [ -e /usr/share/terminfo/x/xterm-256color ] && [[ $TERM != screen* ]]; then
	export TERM='xterm-256color'
fi

# Colorize outputs
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\w\$(if [[ \$? == 0 ]]; then printf \"\[\033[01;32m\]\"; else printf \"\[\033[00;31m\]\"; fi)\$\[\033[00m\] "

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
