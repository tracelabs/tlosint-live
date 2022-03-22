#!/bin/bash



# Log output to STDOUT and to a file.
export logPath="squid_setup.log"
exec &> >( tee -a $logPath)

##### Fix display output for GUI programs (when connecting via SSH)
export DISPLAY=:0.0
export TERM=xterm


##### Check if we are running as root - else this script will fail
function root_check {	
	if [[ "${EUID}" -ne 0 ]]; then
	  echo -e "[!] This script must be run as root" 1>&2
	  echo -e "[!] Quitting..." 1>&2
	  exit 1
	else
	  internet_access
	fi
}	

##### Check Internet access 
function internet_access {
	#--- Can we ping google?
	for i in {1..10}; do ping -c 1 -W ${i} www.google.com &>/dev/null && break; done
	#--- Run this, if we can't
	if [[ "$?" -ne 0 ]]; then
	  echo -e '[!]'" Possible DNS issues(?)" 1>&2
	  echo -e '[!]'" Will try and use DHCP to 'fix' the issue" 1>&2
	  chattr -i /etc/resolv.conf 2>/dev/null
	  dhclient -r
	  dhclient
	  dhclient eth0 2>/dev/null
	  dhclient wlan0 2>/dev/null
	  #--- Wait and see what happens
	  sleep 15s
	  _TMP="true"
	  _CMD="$(ping -c 1 8.8.8.8 &>/dev/null)"
	  if [[ "$?" -ne 0 && "$_TMP" == "true" ]]; then
		_TMP="false"
		echo -e '[!]'" No Internet access" 1>&2
		echo -e '[!]'" You will need to manually fix the issue, before re-running this script" 1>&2
	  fi
	  _CMD="$(ping -c 1 www.google.com &>/dev/null)"
	  if [[ "$?" -ne 0 && "$_TMP" == "true" ]]; then
		_TMP="false"
		echo -e '[!]'" Possible DNS issues(?)" 1>&2
		echo -e '[!]'" You will need to manually fix the issue, before re-running this script" 1>&2
	  fi
	  if [[ "$_TMP" == "false" ]]; then
		(dmidecode | grep -iq virtual) && echo -e " [i] VM Detected"
		(dmidecode | grep -iq virtual) && echo -e " [i] Try switching network adapter mode (e.g. NAT/Bridged)"
		echo -e '[!]'" You will need to manually fix the issue, before re-running this script, trying anyway" 1>&2
		tlosint-install
	  fi
	else
	  echo -e " [i] Detected Internet access" 1>&2
	  tlosint-install
	fi
}

##### tlosint-live installation
function tlosint-install {
	
	##### OS Version
	OS_VERSION=$(cat /etc/issue)
	
	kali_path="/opt/live-build-config"
	tl_path="/opt/tlosint-live"
	
	# check for kali live build on system
	if [ -d "$kali_path" ]; then
      # check for tlosint-live on system
	  if [ -d "$tl_path" ]; then
	    # check for not using Kali
		if [ "$OS_VERSION" != "Kali GNU/Linux Rolling \n \l" ]; then
		  apt-get -qq install gnupg
		  # download kali signing key
  		  wget -q 'https://archive.kali.org/archive-key.asc'
		  gpg --import archive-key.asc	
		  rm -f archive-key.asc
		  # put key where apt will be expecting it
		  gpg --export 44C6513A8E4FB3D30875F758ED444FF07D8D0BF6 > /usr/share/keyrings/kali-archive-keyring.gpg
		  
		  cat /etc/apt/sources.list > /etc/apt/sources.list.orig
		  echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
		  
		  
		  apt-get update -qq
		
		else
		    # save host system apt settings
		    cat /etc/apt/sources.list > /etc/apt/sources.list.orig

	    fi
		
		
		apt-get update -qq -y 
		dpkg --configure -a
		apt --fix-broken install
		echo "[+] Updates done ... "

		apt-get install curl git -y
		apt-get install live-build -y
		apt-get install cdebootstrap -y
		echo "[+] Live build pre-requisites installed ... "

	    # Copy all the files required for the Tracelabs ISO to the latest Kali live-build repo
		cp -rfv $tl_path/kali-config/variant-tracelabs/ $kali_path/kali-config/
		cp -rfv $tl_path/kali-config/common/hooks/normal $kali_path/kali-config/common/hooks/
		cp -rfv $tl_path/kali-config/common/includes.chroot/etc/* $kali_path/kali-config/common/includes.chroot/etc/
		cp -rfv $tl_path/kali-config/common/includes.chroot/usr/* $kali_path/kali-config/common/includes.chroot/usr/

		echo "[+] Kali ISO build process starting ... "
		##### removing version check to allow build on ubuntu (DON'T REMOVE, NEED THIS FOR CI\CD)
		#sed -i '161s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '166s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '177s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '182s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '181s/.*/#exit 1/' /opt/live-build-config/build.sh
		$kali_path/build.sh --verbose --variant tracelabs
		#rm -f kali-archive-keyring_2020.2_all.deb
		# restore original apt settings
		cat /etc/apt/sources.list.orig > /etc/apt/sources.list
		rm -f /etc/apt/sources.list.orig
       # if tlosint-live not in place
	  else
	      file_path=$(realpath $0)
	      repo_path=$(dirname "$file_path")
		  cp -r "$repo_path" "$tl_path"
		
		  tlosint-install
	  
	  fi


     # if live-build-config not in place
	else
		# Clone the Kali live-build and Tracelabs repositories 
		echo "[+] tlosint-live & live-build-config directories not found, creating."
		git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git /opt/live-build-config
        #copy current branch for building
		file_path=$(realpath $0)
	    repo_path=$(dirname "$file_path")
		cp -r "$repo_path" "$tl_path"
		
		tlosint-install
	fi
    
}
		
root_check
#clean up
iso_path=$(find /opt/live-build-config -name "*.iso")
mv "$iso_path" /opt/
rm -rf "$kali_path"
rm -rf "$tl_path"
