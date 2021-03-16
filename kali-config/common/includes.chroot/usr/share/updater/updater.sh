#!/usr/bin/env bash

cd /home/osint

wget -O updater-current.sh https://raw.githubusercontent.com/tracelabs/tlosint-live/master/updater-current.sh

chmod +x updater-current.sh

sudo /home/osint/updater-current.sh

wget -O bookmarks.html https://raw.githubusercontent.com/tracelabs/tlosint-live/master/bookmarks.html

rm -f updater-current.sh


############################