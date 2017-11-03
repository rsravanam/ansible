# Arguments
ARG  IMAGE_REPO=sravanam1242/private_docker
ARG  IMAGE_NAME=ubuntu
ARG  IMAGE_VERSION=14.04

# Add User
#RUN useradd elk-poc sudo
#RUN echo elk-poc | passwd elk-poc --stdin

# our base image
FROM ${IMAGE_REPO}:${IMAGE_NAME}-${IMAGE_VERSION}

# Update the packages.
RUN apt-get update

# Install a few utility tools.
RUN apt-get install -y tar wget git

# Remove old ones
RUN rm -rf /elasticsearch-5.6.3.tar.gz /elasticsearch-5.6.3/ /opt/kibana-5.6.3-linux-x86_64.tar.gz /opt/kibana-5.6.3-linux-x86_64

# Install Java
RUN apt-get update
RUN apt-get -y -q update
RUN apt-get -y -q upgrade
RUN apt-get -y -q install software-properties-common htop
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update -y
RUN yes | apt-get install openjdk-8-jdk
RUN update-alternatives --config java
RUN update-alternatives --config javac

# Get Kibana
RUN cd /opt && wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.3-linux-x86_64.tar.gz
RUN cd /opt && sha1sum kibana-5.6.3-linux-x86_64.tar.gz 
RUN cd /opt && tar -xzvf kibana-5.6.3-linux-x86_64.tar.gz

# Get Elastisearch.
RUN cd /opt && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.tar.gz
RUN cd /opt && sha1sum elasticsearch-5.6.3.tar.gz 
RUN cd /opt && tar -xzvf elasticsearch-5.6.3.tar.gz

# Elastisearch Installation
# RUN cd elasticsearch-5.6.3/bin && ./elasticsearch

# Get Logstach
RUN cd /opt && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN cd /opt && apt-get install apt-transport-https
RUN cd /opt && echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN cd /opt && apt-get update && sudo apt-get install logstash

