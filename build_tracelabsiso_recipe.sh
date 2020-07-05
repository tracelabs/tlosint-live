#! /bin/bash
# Abort the execution if any of the step fails
set -e

# Log output to STDOUT and to a file.
logPath="squid_setup.log"
exec &> >( tee -a $logPath)

# Clone the Kali live-build and Tracelabs repositories 
#git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git /opt/live-build-config
#git clone https://github.com/tracelabs/tlosint-live.git /opt/tlosint-live

kali_path="/opt/live-build-config"
tl_path="/opt/tlosint-live"

sudo -s -- <<EOF
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
EOF
