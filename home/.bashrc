#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Set prompt
PS1='[\u@\h \W]\$ '

