FROM kalilinux/kali-rolling

COPY . /tlosint-live

# Base packages
RUN export DISPLAY=:0.0 &&\
	export TERM=xterm &&\
	DEBIAN_FRONTEND=noninteractive &&\
	apt-get update -qq &&\
   	apt-get install --no-install-recommends -y -qq\
	apt-utils \
      	wget \
      	git \
      	sed \
      	unzip \
      	curl \
      	gnupg \
      	net-tools \
      	python3-setuptools \
      	python3 \
      	python3-pip \
      	software-properties-common \
	sudo \
	schroot \
	debootstrap \ 
	cdebootstrap \
	dnsutils \ 
	iproute2 \ 
	iputils-ping \ 
	libunwind8 \ 
	locales \ 
	pkg-config \ 
	fakeroot \ 
	dpkg \ 
	zip \ 
	fdisk \
	mount \
	build-essential \ 
	cmake \ 
	bash-completion \
	live-build \
	cpio

# Start
RUN echo '#!/usr/bin/env bash \n\
	sudo sed -i '1161s%umount%#umount%' /usr/share/debootstrap/functions \n\
	sudo sed -i '1191s%umount%#umount%' /usr/share/debootstrap/functions  \n\
	sudo sed -i '1179s%umount%#umount%' /usr/share/debootstrap/functions  \n\
	cd /tlosint-live \n\
	sudo ./build_tracelabsiso_recipe.sh \n\
    cp /opt/kali-linux-rolling-live-tracelabs-amd64.iso /data/kali-linux-rolling-live-tracelabs-amd64.iso' > /opt/run.sh &&\
    chmod +x /opt/run.sh


# Clean up
RUN apt-get clean &&\
    apt-get clean autoclean &&\
    apt-get autoremove -y &&\
    rm -rf /tmp/* &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}/

VOLUME [ "/data" ]


ENTRYPOINT ["/bin/bash"]

CMD ["-c","/opt/run.sh"]
