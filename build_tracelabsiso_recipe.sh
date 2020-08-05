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
	  echo -e " This script must be run as root" 1>&2
	  echo -e " Quitting..." 1>&2
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
		echo -e '[!]'" Quitting..." 1>&2
		exit 1
	  fi
	else
	  echo -e " [i] Detected Internet access" 1>&2
	  tlosint-install
	fi
}

##### tlosint-live installation
function tlosint-install {
	# Clone the Kali live-build and Tracelabs repositories 
	git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git /opt/live-build-config
	git clone https://github.com/xFreed0m/tlosint-live.git /opt/tlosint-live
	
	kali_path="/opt/live-build-config"
	tl_path="/opt/tlosint-live"
	
	if [ -d $kali_path ]
	then
		if [ -d $tl_path ]
		then
			apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
			echo "Updates done ... "

			apt-get install curl git live-build cdebootstrap squid -y
			echo "Live build pre-requisites installed ... "

			wget -O /etc/squid/squid.conf https://raw.githubusercontent.com/prateepb/kali-live-build/master/squid.conf
			/etc/init.d/squid start
			grep -qxF "http_proxy=http://localhost:3128/"  /etc/environment || echo "http_proxy=http://localhost:3128/" >> /etc/environment
			echo "Squid set-up completed .... "

		# Copy all the files required for the Tracelabs ISO to the latest Kali live-build repo
			cp -rv $tl_path/kali-config/variant-tracelabs/ $kali_path/kali-config/
			cp -rv $tl_path/kali-config/common/hooks/normal $kali_path/kali-config/common/hooks/
			cp -rv $tl_path/kali-config/common/includes.chroot/etc/* $kali_path/kali-config/common/includes.chroot/etc/
			cp -rv $tl_path/kali-config/common/includes.chroot/usr/* $kali_path/kali-config/common/includes.chroot/usr/

			echo "Kali ISO build process starting ... "
			$kali_path/build.sh --verbose --variant tracelabs -- --apt-http-proxy=${http_proxy}
		else
			echo "Tracelabs path does not exist"
		fi
	else
		echo "Kali live build path does not exist"
	fi
}
		
root_check

#EOF
