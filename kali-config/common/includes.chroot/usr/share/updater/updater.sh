#!/usr/bin/env bash
tput setaf 5;echo "#################"
tput setaf 5;echo "# OSINT Updater #"
tput setaf 5;echo "#################"

# tput setaf 5;echo "[+] Updating system..."
# {
#        sudo apt update
#        sudo apt upgrade -y
# } 
# tput setaf 2;echo "[+] Done."

###############

tput setaf 5;echo "[+] Updating youtube-dl..."
{
        sudo -H pip3 install --upgrade youtube-dl
} 
tput setaf 2;echo "[+] Done."

################

tput setaf 5;echo "[+] Updating Instaloader..."
{
        sudo -H pip3 install --upgrade instaloader
} 
tput setaf 2;echo "[+] Done."

#################

tput setaf 5;echo "[+] Updating Twint..."
{
        sudo -H pip3 install --upgrade twint
} 
tput setaf 2;echo "[+] Done."

#################

tput setaf 5;echo "[+] Updating Sublist3r..."
{
        cd /usr/share/Sublist3r
        sudo git pull https://github.com/aboul3la/Sublist3r.git
} 
tput setaf 2;echo "[+] Done."

##################

tput setaf 5;echo "[+] Updating LittleBrother..."
{
        cd /usr/share/LittleBrother
        sudo git pull https://github.com/Lulz3xploit/LittleBrother
} 
tput setaf 2;echo "[+] Done."

##################

tput setaf 5;echo "[+] Updating PhoneInfoga..."
{
        cd /usr/share/PhoneInfoga
        sudo git pull https://github.com/sundowndev/PhoneInfoga.git
} 
tput setaf 2;echo "[+] Done."

###################

tput setaf 5;echo "[+] Updating theHarvester..."
{
        cd /usr/share/theHarvester
        sudo git pull https://github.com/laramies/theHarvester.git
} 
tput setaf 2;echo "[+] Done."

####################

tput setaf 5;echo "[+] Updating ExifScan..."
{
        cd /usr/share/exifscan
        sudo git pull https://github.com/rcook/exifscan.git
} 
tput setaf 2;echo "[+] Done."

#####################

tput setaf 5;echo "[+] Updating DumpsterDiver..."
{
        cd /usr/share/DumpsterDiver
        sudo git pull https://github.com/securing/DumpsterDiver.git
} 
tput setaf 2;echo "[+] Done."

######################

tput setaf 5;echo "[+] Updating Sherlock..."
{
        cd /usr/share/sherlock
        sudo git pull https://github.com/sherlock-project/sherlock.git
} 
tput setaf 2;echo "[+] Done."

#######################

tput setaf 5;echo "[+] Updating Skiptracer..."
{
        cd /usr/share/skiptracer
        sudo git pull https://github.com/xillwillx/skiptracer.git
} 
tput setaf 2;echo "[+] Done."

########################

tput setaf 5;echo "[+] Updating FBI (Facebook Information)..."
{
        cd /usr/share/fbi
        sudo git pull https://github.com/xHak9x/fbi.git
} 
tput setaf 2;echo "[+] Done."

#########################

tput setaf 5;echo "[+] Updating Infoga..."
{
        cd /usr/share/Infoga
        sudo git pull https://github.com/m4ll0k/Infoga.git
} 
tput setaf 2;echo "[+] Done."

#########################

tput setaf 5;echo "[+] Updating Metagoofil..."
{

	cd /usr/share/metagoofil
        sudo git pull https://github.com/opsdisk/metagoofil.git
} 
tput setaf 2;echo "[+] Done."

##########################

tput setaf 5;echo "[+] Updating OSINT-Search..."
{
        cd /usr/share/OSINT-Search
        sudo git pull https://github.com/am0nt31r0/OSINT-Search.git
        sudo pip3 install git+https://github.com/abenassi/Google-Search-API
 --upgrade
        sudo pip3 install https://github.com/PaulSec/API-dnsdumpster.com/ar
chive/master.zip --user
} 
tput setaf 2;echo "[+] Done."

###########################

tput setaf 5;echo "[+] Updating Stego Toolkit..."
{
        cd /usr/share/stego-toolkit
        sudo git pull https://github.com/DominicBreuker/stego-toolkit.git
} 
tput setaf 2;echo "[+] Done."
###########################

tput setaf 5;echo "[+] Updating Photon..."
{
        cd /usr/share/Photon
        sudo git pull https://github.com/s0md3v/Photon.git
} 
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating sn0int..."
{
        cd /usr/share/sn0int
        sudo git pull https://github.com/kpcyrd/sn0int.git
        cargo install -f --path .
} 
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating sn0int..."
{
        cd /usr/share/sn0int
        sudo git pull https://github.com/kpcyrd/sn0int.git
	cargo install -f --path .
} 
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating Spiderpig..."
{
        cd /usr/share/Spiderpig
        sudo git pull https://github.com/hatlord/Spiderpig.git
        bundle install
}
tput setaf 2;echo "[+] Done."

############################

