#!/bin/bash

rsync -rv --size-only --delete --progress /mnt/hdd/Music/ /run/media/ryp/iPodClassic/Music/
sync
