#!/bin/bash

cat << EOF
Read presetup.checklist file before running this script.
Read postsetup.checklist file after running this script.
Do not run this script as root, because the home directory will be modified.
Run this script in it's directory.
Make sure you have write permissions for this directory.
You will be asked for your input during the execution of this script.

Assume this operation is IRREVERSIBLE.

If you do not follow above instructions, the script will fail.

By typing exactly 'ok' you have acknowledged the above message and are ready to execute the script.
EOF

read input

[[ ! "$input" == "ok" ]] && exit 1

# SYNC SYSTEM
sudo pacman -Syyu
sudo pacman -S --needed python git

# INSTALL AUR HELPER
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay/

# INSTALL PACKAGES
sysman package sync

# POST INSTALL
sysman service sync
chsh -s /usr/bin/zsh
sudo usermod -a -G video "$USER"

# INSTALL DOTFILES
[[ -f "$HOME/.bashrc" ]] && rm "$HOME/.bashrc"
[[ -f "$HOME/.bash_profile" ]] && rm "$HOME/.bash_profile"

(find system -type f | xargs sudo chown root:root) && sudo stow --no-folding -t / system
stow --no-folding config
stow --no-folding home
stow --no-folding src
stow --no-folding svc
stow --no-folding themes
stow --no-folding fonts

[ -d "$HOME/.local" ] || mkdir "$HOME/.local"
[ -d "$HOME/.local/bin" ] || mkdir "$HOME/.local/bin"
find ./src/.local/src -maxdepth 1 -type f -printf "%P\n" | while read file; do ln -s "$HOME/.local/src/$file" "$HOME/.local/bin/$file"; done

# CREATE MISSING XDG FOLDERS
[[ ! -d "$HOME/docs" ]] && mkdir "$HOME/docs"
[[ ! -d "$HOME/downloads" ]] && mkdir "$HOME/downloads"
[[ ! -d "$HOME/music" ]] && mkdir "$HOME/music"
[[ ! -d "$HOME/pictures" ]] && mkdir "$HOME/pictures"
[[ ! -d "$HOME/movies" ]] && mkdir "$HOME/movies"
