#!/usr/bin/env bash
tput setaf 5;echo "###############################"
tput setaf 5;echo "# Trace Labs OSINT VM Updater #"
tput setaf 5;echo "###############################"

echo "[+] Update + Upgrade System.."
sudo apt update -qq 
sudo apt upgrade -qq -y
sudo npm install npm@latest -g
sudo npm update -g

echo "[+] Upgrading Kali version to latest..."
sudo apt dist-upgrade -qq -y
sudo apt full-upgrade -qq -y

echo "[+] 2021.2 OVA fixup..."

# Fix: ORIG_HEAD broken reference
sudo find /usr/share/ -name ORIG_HEAD -size -1b -delete

# Fix: sherlock no such file
sudo sed -i 's/\/usr\/share\/sherlock\/sherlock\.py/\/usr\/share\/sherlock\/sherlock\/sherlock.py/' /usr/bin/sherlock

# Fix: stego-toolkit and exifscan
clean_dir() {
  if [ -d "${1}" ]; then
        if [ "$(wc -c <"${1}"/README.md)" -lt 1 ]; then
            echo README.md is zero byte size fixing..
            # Regular update process should clone when it sees no dir
            sudo rm -rf "${1}"
        fi
    fi
}

STEGO_DIR=/usr/share/stego-toolkit
EXIFSCAN_DIR=/usr/share/exifscan

clean_dir "${STEGO_DIR}"
clean_dir "${EXIFSCAN_DIR}"

#################

tput setaf 5;echo "[+] Replace Kali Firefox Bookmarks..."
{
sudo wget -O /usr/share/firefox-esr/distribution/distribution.ini https://raw.githubusercontent.com/tracelabs/tlosint-live/master/kali-config/common/includes.chroot/usr/share/firefox-esr/distribution/distribution.ini
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
	fi
}
tput setaf 2;echo "[+] Done."

##################

tput setaf 5;echo "[+] Updating PhoneInfoga..."
{
    PHONEINFOGA_RELEASE="latest" # examples: latest, tag/v2.0.8
	PHONEINFOGA_FILE=/usr/share/phoneinfoga/phoneinfoga_"$(uname -s)"_"$(uname -m)".tar.gz
	PHONEINFOGA_URL=https://github.com/sundowndev/phoneinfoga/releases/"${PHONEINFOGA_RELEASE}"/download/phoneinfoga_"$(uname -s)"_"$(uname -m)".tar.gz
	
	cd /usr/share/phoneinfoga || sudo mkdir -p /usr/share/phoneinfoga && cd /usr/share/phoneinfoga/
	http_response=$(sudo curl -L -o "${PHONEINFOGA_FILE}" -z "${PHONEINFOGA_FILE}" "${PHONEINFOGA_URL}" -s -w "%{http_code}" 2>/dev/null)
	if [ "${http_response}" -eq 200 ]; then
	    echo "New version found updating.."
	    sudo tar xvf "${PHONEINFOGA_FILE}"
	    sudo chmod +x /usr/bin/phoneinfoga
	elif [ "${http_response}" -eq 304 ]; then
	    echo "No updates found.."
	else
	    echo "Failed to get update. HTTP_ERROR ${http_response}"
	fi

}
tput setaf 2;echo "[+] Done."

###################

tput setaf 5;echo "[+] Updating ExifScan..."
{
        if [ -d "/usr/share/exifscan" ]; then        
	
		cd /usr/share/exifscan
        	sudo git pull https://github.com/rcook/exifscan.git --rebase
	else
		sudo git clone https://github.com/rcook/exifscan /usr/share/exifscan
	fi
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
	fi
} 
tput setaf 2;echo "[+] Done."

######################

tput setaf 5;echo "[+] Updating Sherlock..."
{
        if [ -d "/usr/share/sherlock" ]; then        
	
		cd /usr/share/sherlock
		sudo git init
        	sudo git pull https://github.com/sherlock-project/sherlock.git --rebase
	else
		sudo git clone https://github.com/sherlock-project/sherlock /usr/share/sherlock
	fi
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
	fi
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
	fi
} 
tput setaf 2;echo "[+] Done."

###########################


tput setaf 5;echo "[+] Updating sn0int..."
{
        if [ -d "/usr/share/sn0int" ]; then        
	
		cd /usr/share/sn0int
        	sudo git pull https://github.com/kpcyrd/sn0int.git --rebase
        	sudo cargo install -f --path .
	else
		sudo git clone https://github.com/kpcyrd/sn0int /usr/share/sn0int
	fi
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
	fi
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
	fi
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
	fi
}
tput setaf 2;echo "[+] Done."

############################

tput setaf 5;echo "[+] Updating OnionSearch..."
{
  if [ -d "/usr/share/OnionSearch" ]; then        
    cd /usr/share/OnionSearch
    sudo git pull https://github.com/megadose/OnionSearch.git --rebase
	else
    sudo git clone https://github.com/megadose/OnionSearch.git /usr/share/OnionSearch
	fi
}
tput setaf 2;echo "[+] Done."


tput setaf 5;echo "[+] Updating Twayback..."
{
  if [ -d "/usr/share/twayback" ]; then        
    cd /usr/share/twayback
    sudo git pull https://github.com/Mennaruuk/twayback.git --rebase
	else
    sudo git clone https://github.com/Mennaruuk/twayback.git /usr/share/twayback
	fi
}
tput setaf 2;echo "[+] Done."

############################



