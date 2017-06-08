#!/usr/bin/env bash
#
# This script searches for the last merge commit containing
# the specified commit on the current branch

SHA1=$1

git log $SHA1..HEAD --ancestry-path --merges --reverse --pretty=oneline | head -1
