#!/bin/bash
# Abort the execution if any of the step fails
#set -e

# Log output to STDOUT and to a file.
export logPath="squid_setup.log"
exec &> >( tee -a $logPath)


#sudo -s -- <<EOF
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
	  #--- Second interface causing issues?
	  ip addr show eth1 &>/dev/null
	  [[ "$?" == 0 ]] \
		&& route delete default gw 192.168.155.1 2>/dev/null
	  #--- Request a new IP
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

	
	##### Disabling the lockscreen
	xset s 0 0
    xset s off
    gsettings set org.gnome.desktop.session idle-delay 0
	
	kali_path="/opt/live-build-config"
	tl_path="/opt/tlosint-live"
	
	if [ -d "$kali_path" ]; then
		
	  if [ -d "$tl_path" ]; then
	    
		if [ "$OS_VERSION" != "Kali GNU/Linux Rolling \n \l" ]; then
		  wget https://http.kali.org/pool/main/k/kali-archive-keyring/kali-archive-keyring_2020.2_all.deb
		  wget https://archive.kali.org/kali/pool/main/l/live-build/live-build_20191221kali4_all.deb
		  apt-get install git live-build cdebootstrap debootstrap curl squid -y
		  dpkg -i kali-archive-keyring_2018.1_all.deb
		  dpkg -i live-build_20180618kali1_all.deb
		  cd /usr/share/debootstrap/scripts/
		  (echo "default_mirror http://http.kali.org/kali"; sed -e "s/debian-archive-keyring.gpg/kali-archive-keyring.gpg/g" sid) > kali
		  ln -s kali kali-rolling
		  cd ~
	    fi
		
		apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
		echo "[+] Updates done ... "

		apt-get install curl git live-build cdebootstrap squid -y
		echo "[+] Live build pre-requisites installed ... "

		wget -O /etc/squid/squid.conf https://raw.githubusercontent.com/prateepb/kali-live-build/master/squid.conf
		/etc/init.d/squid start
		grep -qxF "http_proxy=http://localhost:3128/"  /etc/environment || echo "http_proxy=http://localhost:3128/" >> /etc/environment
		echo "[+] Squid set-up completed .... "

	    # Copy all the files required for the Tracelabs ISO to the latest Kali live-build repo
		cp -rfv $tl_path/kali-config/variant-tracelabs/ $kali_path/kali-config/
		cp -rfv $tl_path/kali-config/common/hooks/normal $kali_path/kali-config/common/hooks/
		cp -rfv $tl_path/kali-config/common/includes.chroot/etc/* $kali_path/kali-config/common/includes.chroot/etc/
		cp -rfv $tl_path/kali-config/common/includes.chroot/usr/* $kali_path/kali-config/common/includes.chroot/usr/

		echo "[+] Kali ISO build process starting ... "
		##### removing version check to allow build on ubuntu (DON'T REMOVE, NEED THIS FOR CI\CD)
		#sed -i '161s/.*/#exit 1/' /opt/live-build-config/build.sh
		sed -i '166s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '177s/.*/#exit 1/' /opt/live-build-config/build.sh
		#sed -i '182s/.*/#exit 1/' /opt/live-build-config/build.sh
		$kali_path/build.sh --verbose --variant tracelabs -- --apt-http-proxy=${http_proxy}
	  fi

	else
		# Clone the Kali live-build and Tracelabs repositories 
		echo "[+] tlosint-live & live-build-config directories not found, creating."
		git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git /opt/live-build-config
		git clone https://github.com/tracelabs/tlosint-live.git /opt/tlosint-live
		# `mkdir -p "$kali_path" && mkdir -p "$tl_path"`
		tlosint-install
	fi
}
		
root_check

#EOF
