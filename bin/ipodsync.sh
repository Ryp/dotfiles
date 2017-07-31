#!/bin/bash

rsync -rv --size-only --delete --progress /mnt/hdd/Music/ /mnt/usb/Music/
sync
