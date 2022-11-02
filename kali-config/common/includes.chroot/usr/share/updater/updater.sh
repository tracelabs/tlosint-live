#!/usr/bin/env bash

cd $HOME/Desktop

wget -O updater-current.sh https://raw.githubusercontent.com/tracelabs/tlosint-live/tom-installer-script/install-and-update-tools.sh

chmod +x install-and-update-tools.sh

sudo $HOME/install-and-update-tools.sh

wget -O bookmarks.html https://raw.githubusercontent.com/tracelabs/tlosint-live/master/bookmarks.html




############################