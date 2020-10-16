#!/usr/bin/env bash
tput setaf 5;echo "#################"
tput setaf 5;echo "# OSINT Updater #"
tput setaf 5;echo "#################"

echo "[+] Update System.."
sudo apt update -qq
sudo apt upgrade -qq -y

tput setaf 5;echo "[+] Updating youtube-dl..."
{
        sudo -H pip3 install --upgrade youtube-dl
} 
tput setaf 2;echo "[+] Done."

#################

tput setaf 5;echo "[+] Updating Twint..."
{
        sudo -H pip3 install --upgrade twint
} 
tput setaf 2;echo "[+] Done."


##################

tput setaf 5;echo "[+] Updating LittleBrother..."
{
	if [ -d "/usr/share/LittleBrother" ]; then        
	
		cd /usr/share/LittleBrother
        	sudo git pull https://github.com/Lulz3xploit/LittleBrother --rebase
	else
		sudo git clone https://github.com/Lulz3xploit/LittleBrother /usr/share/LittleBrother
} 
tput setaf 2;echo "[+] Done."

##################

tput setaf 5;echo "[+] Updating PhoneInfoga..."
{
        if [ -d "/usr/share/phoneinfoga" ]; then        
	
		cd /usr/share/phoneinfoga
        	sudo git pull https://github.com/sundowndev/PhoneInfoga.git --rebase
	else
		sudo git clone https://github.com/sundowndev/PhoneInfoga.git /usr/share/phoneinfoga
} 

tput setaf 2;echo "[+] Done."

###################

tput setaf 5;echo "[+] Updating theHarvester..."
{
        if [ -d "/usr/share/theHarvester" ]; then        
	
		cd /usr/share/theHarvester
        	sudo git pull https://github.com/laramies/theHarvester.git  --rebase
	else
		sudo git clone https://github.com/laramies/theHarvester.git /usr/share/theHarvester
} 
tput setaf 2;echo "[+] Done."

####################

tput setaf 5;echo "[+] Updating ExifScan..."
{
        if [ -d "/usr/share/exifscan" ]; then        
	
		cd /usr/share/exifscan
        	sudo git pull https://github.com/rcook/exifscan.git --rebase
	else
		sudo git clone https://github.com/rcook/exifscan /usr/share/exifscan
} 
tput setaf 2;echo "[+] Done."

#####################

tput setaf 5;echo "[+] Updating DumpsterDiver..."
{
        if [ -d "/usr/share/DumpsterDiver" ]; then        
	
		cd /usr/share/DumpsterDiver
		sudo git pull https://github.com/securing/DumpsterDiver.git --rebase
	else
		sudo git clone https://github.com/securing/DumpsterDiver /usr/share/DumpsterDiver
} 
tput setaf 2;echo "[+] Done."

######################

tput setaf 5;echo "[+] Updating Sherlock..."
{
        if [ -d "/usr/share/sherlock" ]; then        
	
		cd /usr/share/sherlock
        	sudo git pull https://github.com/sherlock-project/sherlock.git --rebase
	else
		sudo git clone https://github.com/sherlock-project/sherlock /usr/share/sherlock
} 
tput setaf 2;echo "[+] Done."


#########################

tput setaf 5;echo "[+] Updating Infoga..."
{
        if [ -d "/usr/share/Infoga" ]; then        
	
		cd /usr/share/Infoga
        	sudo git pull https://github.com/m4ll0k/Infoga.git --rebase
	else
		sudo git clone https://github.com/m4ll0k/Infoga /usr/share/Infoga
} 
tput setaf 2;echo "[+] Done."

#########################

tput setaf 5;echo "[+] Updating Metagoofil..."
{

	if [ -d "/usr/share/metagoofil" ]; then        
	
		cd /usr/share/metagoofil
        	sudo git pull https://github.com/opsdisk/metagoofil.git --rebase
	else
		sudo git clone https://github.com/opsdisk/metagoofil /usr/share/metagoofil
} 
tput setaf 2;echo "[+] Done."

##########################

tput setaf 5;echo "[+] Updating OSINT-Search..."
{
        if [ -d "/usr/share/OSINT-Search" ]; then        
	
		cd /usr/share/OSINT-Search
        	sudo git pull https://github.com/am0nt31r0/OSINT-Search.git --rebase
        	sudo pip3 install git+https://github.com/abenassi/Google-Search-API --upgrade
       		sudo pip3 install https://github.com/PaulSec/API-dnsdumpster.com/archive/master.zip --user
	else
		sudo git clone https://github.com/am0nt31r0/OSINT-Search /usr/share/OSINT-Search
} 
tput setaf 2;echo "[+] Done."

###########################

tput setaf 5;echo "[+] Updating Stego Toolkit..."
{
        if [ -d "/usr/share/stego-toolkit" ]; then        
	
		cd /usr/share/stego-toolkit
        	sudo git pull https://github.com/DominicBreuker/stego-toolkit.git --rebase
	else
		sudo git clone https://github.com/DominicBreuker/stego-toolkit.git  /usr/share/stego-toolkit
} 
tput setaf 2;echo "[+] Done."

###########################


tput setaf 5;echo "[+] Updating sn0int..."
{
        if [ -d "/usr/share/sn0int" ]; then        
	
		cd /usr/share/sn0int
        	sudo git pull https://github.com/kpcyrd/sn0int.git --rebase
        	cargo install -f --path .
	else
		sudo git clone https://github.com/kpcyrd/sn0int /usr/share/sn0int
}  
tput setaf 2;echo "[+] Done."


############################

tput setaf 5;echo "[+] Updating Spiderpig..."
{
        if [ -d "/usr/share/Spiderpig" ]; then        
	
		cd /usr/share/Spiderpig
        	sudo git pull https://github.com/hatlord/Spiderpig.git --rebase
        	bundle install
	else
		sudo git clone https://github.com/hatlord/Spiderpig /usr/share/Spiderpig
}
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating WhatsMyName..."
{
        if [ -d "/usr/share/WhatsMyName" ]; then        
	
		cd /usr/share/WhatsMyName
        	sudo git pull https://github.com/WebBreacher/WhatsMyName.git --rebase
	else
		sudo git clone https://github.com/WebBreacher/WhatsMyName /usr/share/WhatsMyName
}
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating WikiLeaker..."
{
        if [ -d "/usr/share/WikiLeaker" ]; then        
	
		cd /usr/share/WikiLeaker
        	sudo git pull https://github.com/jocephus/WikiLeaker.git --rebase
	else
		sudo git clone https://github.com/jocephus/WikiLeaker /usr/share/WikiLeaker
}
tput setaf 2;echo "[+] Done."
