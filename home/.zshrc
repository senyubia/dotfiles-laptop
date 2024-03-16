#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If running from tty as fbterm, get hijacked by tmux with working 256 colors
if [[ $USES_TTY -eq "1" ]] && [[ $TERM == "linux" ]]; then
	export TERM=fbterm-256color
	tmux

	rm /tmp/usingTTY
	exit
fi

# Set aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Set prompt
if [[ $USES_TTY -eq "0"  ]]; then
	[[ -f ~/.p10k.zsh ]] && . ~/.p10k.zsh
else
	[[ -f ~/.p10k.zsh.tty ]] && . ~/.p10k.zsh.tty
fi

# Set variables
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
ZLE_RPROMPT_INDENT=0

# Set options
setopt autocd
setopt extendedglob
setopt nomatch
setopt COMPLETE_ALIASES

unsetopt beep
unsetopt notify

# Set keybindings
bindkey -e

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Backspace]="^H"
key[Delete]="${terminfo[kdch1]}"
key[Control-Delete]="^[[3;5~"

[[ -n "${key[Home]}"              ]] && bindkey -- "${key[Home]}"              beginning-of-line
[[ -n "${key[End]}"               ]] && bindkey -- "${key[End]}"               end-of-line
[[ -n "${key[Control-Left]}"      ]] && bindkey -- "${key[Control-Left]}"      backward-word
[[ -n "${key[Control-Right]}"     ]] && bindkey -- "${key[Control-Right]}"     forward-word
[[ -n "${key[Control-Backspace]}" ]] && bindkey -- "${key[Control-Backspace]}" backward-kill-word
[[ -n "${key[Delete]}"            ]] && bindkey -- "${key[Delete]}"            delete-char
[[ -n "${key[Control-Delete]}"    ]] && bindkey -- "${key[Control-Delete]}"    kill-word

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Other
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion*' menu select
zstyle ':completion*' rehash true

autoload -Uz compinit
compinit
