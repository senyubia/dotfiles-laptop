#!/bin/bash

pkgdir="/"
pkgname="optimus-manager"

if [ "$EUID" -ne 0 ]
  then echo "Run as sudo"
  exit 1
fi

# build
python -m build --wheel --no-isolation

# install
install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
install -Dm644 modules/optimus-manager.conf "$pkgdir/usr/lib/modprobe.d/optimus-manager.conf"
install -Dm644 systemd/optimus-manager.service "$pkgdir/usr/lib/systemd/system/optimus-manager.service"
install -Dm644 optimus-manager.conf "$pkgdir/usr/share/optimus-manager.conf"

install -Dm644 systemd/logind/10-optimus-manager.conf "$pkgdir/usr/lib/systemd/logind.conf.d/10-optimus-manager.conf"
install -Dm755 systemd/suspend/optimus-manager.py "$pkgdir/usr/lib/systemd/system-sleep/optimus-manager.py"


install -Dm644 login_managers/sddm/20-optimus-manager.conf "$pkgdir/etc/sddm.conf.d/20-optimus-manager.conf"
install -Dm644 login_managers/lightdm/20-optimus-manager.conf  "$pkgdir/etc/lightdm/lightdm.conf.d/20-optimus-manager.conf"

install -Dm644 config/xorg/integrated-mode/integrated-gpu.conf "$pkgdir/etc/optimus-manager/xorg/integrated-mode/integrated-gpu.conf"
install -Dm644 config/xorg/nvidia-mode/nvidia-gpu.conf "$pkgdir/etc/optimus-manager/xorg/nvidia-mode/nvidia-gpu.conf"
install -Dm644 config/xorg/nvidia-mode/integrated-gpu.conf "$pkgdir/etc/optimus-manager/xorg/nvidia-mode/integrated-gpu.conf"
install -Dm644 config/xorg/hybrid-mode/integrated-gpu.conf "$pkgdir/etc/optimus-manager/xorg/hybrid-mode/integrated-gpu.conf"
install -Dm644 config/xorg/hybrid-mode/nvidia-gpu.conf "$pkgdir/etc/optimus-manager/xorg/hybrid-mode/nvidia-gpu.conf"

install -Dm755 config/xsetup-nvidia.sh "$pkgdir/etc/optimus-manager/xsetup-nvidia.sh"
install -Dm755 config/xsetup-hybrid.sh "$pkgdir/etc/optimus-manager/xsetup-hybrid.sh"
install -Dm755 config/xsetup-integrated.sh "$pkgdir/etc/optimus-manager/xsetup-integrated.sh"

install -Dm755 config/nvidia-enable.sh "$pkgdir/etc/optimus-manager/nvidia-enable.sh"
install -Dm755 config/nvidia-disable.sh "$pkgdir/etc/optimus-manager/nvidia-disable.sh"

python -m installer --destdir="$pkgdir" dist/*.whl

# post install
mkdir -p /etc/systemd/system/graphical.target.wants/
ln -s /usr/lib/systemd/system/optimus-manager.service /etc/systemd/system/graphical.target.wants/optimus-manager.service
