FROM ubuntu:24.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt update && \
  apt -y upgrade && \
  apt -y install build-essential wget curl btop xz-utils make git nano vim less neofetch ffmpeg && \
  apt -y install python3 python3-pip ruby-full zlib1g-dev 

RUN \
  cd /opt/ && \
  wget https://nodejs.org/dist/v22.12.0/node-v22.12.0-linux-x64.tar.xz && \
  tar -xvf node-v22.12.0-linux-x64.tar.xz && \
  rm node-v22.12.0-linux-x64.tar.xz

ENV HOME /root
  
RUN \
  echo 'export NODE_HOME=/opt/node-v22.12.0-linux-x64' >> ~/.bashrc && \
  echo 'export PATH=$PATH:$NODE_HOME/bin' >> ~/.bashrc

RUN \
  echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc && \
  echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc && \
  echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc

RUN source ~/.bashrc

RUN gem install jekyll bundler

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root

CMD ["bash"]
