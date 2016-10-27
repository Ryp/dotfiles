#!/bin/bash

whiptail --yesno "Reload kernel ?" 8 24 && sudo kexec -l /boot/vmlinuz-linux --reuse-cmdline --initrd=/boot/initramfs-linux.img && sudo kexec -e
