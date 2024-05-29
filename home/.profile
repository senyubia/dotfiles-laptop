#
# ~/.profile
#

# Export envs
export QT_QPA_PLATFORMTHEME=gtk2

export XCURSOR_PATH=${XCURSOR_PATH}:~/.icons

export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export GTK_IM_MODULE=fcitx5

export EDITOR=nano

#export XDG_SESSION_TYPE=x11

# Flyctl installation
export FLYCTL_INSTALL=$HOME/.fly
export PATH=$FLYCTL_INSTALL/bin:$PATH

# Haskell installation
export PATH=$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH

# Path
export PATH=$HOME/.local/bin:$PATH

# Initialize pyenv
which pyenv 1>/dev/null 2>&1 && eval "$(pyenv init -)"

# Start session depending on tty
# tty1-5 - has gui
# tty6 - use tty
if [[ $(tty) == /dev/tty6 ]]; then
	touch /tmp/usingTTY

	export USES_TTY=1
	exec fbterm
elif [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
	sudo prime-switch

	# Use X11
        export XDG_SESSION_TYPE=x11
	export USES_TTY=0
	exec startx
elif [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty5 ]]; then
        sudo prime-switch

        #  Use wayland
        gpu_mode=$(grep -Po '(nvidia|integrated)' /var/lib/optimus-manager/tmp/state.json)
        if [[ "$gpu_mode" == "nvidia" ]]; then
               export LIBVA_DRIVER_NAME=nvidia
               export GBM_BACKEND=nvidia-drm
               export __GLX_VENDOR_LIBRARY_NAME=nvidia
        fi
               export XDG_SESSION_TYPE=wayland
               export QT_QPA_PLATFORM=wayland
               export USES_TTY=0

               prime-offload
               exec Hyprland
fi
