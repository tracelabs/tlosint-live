FROM ubuntu:18.04

WORKDIR /opt


# Base packages
RUN apt-get update -qq &&\
    apt-get install --no-install-recommends -y -qq\
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
      apt-utils

# Start
RUN echo '#!/usr/bin/env bash \n\
	wget -O - https://raw.githubusercontent.com/tracelabs/tlosint-live/master/build_tracelabsiso_recipe.sh | sudo bash \n\
    cp /opt/live-build-config/images/kali-linux-rolling-live-tracelabs-amd64.iso ' > /opt/run.sh &&\
    chmod +x /opt/run.sh

# Clean up
RUN apt-get clean &&\
    apt-get clean autoclean &&\
    apt-get autoremove -y &&\
    rm -rf /tmp/* &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}/

VOLUME [ "/data" ]


ENTRYPOINT ["/bin/bash"]
CMD ["-c","/opt/run.sh 2>&1 | tee /opt/log.txt"]