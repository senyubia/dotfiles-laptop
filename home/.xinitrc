#
# ~/.xinitrc
#

# Source xinitrc.d scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Required by optimus-manager
prime-offload

# Start WM/DE
if [[ $(tty) == /dev/tty1 ]]; then
	# Start i3
	exec i3
elif [[ $(tty) == /dev/tty2 ]]; then
	# Start i3
	exec i3
elif [[ $(tty) == /dev/tty3 ]]; then
        # Start i3
        exec i3
elif [[ $(tty) == /dev/tty4 ]]; then
        # Start i3
        exec i3
elif [[ $(tty) == /dev/tty5 ]]; then
	# Start i3
	exec i3
fi
