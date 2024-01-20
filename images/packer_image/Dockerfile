FROM jenkins/jnlp-slave:alpine
USER root
RUN apk --no-cache add xorriso redis jq
RUN wget https://releases.hashicorp.com/packer/1.8.5/packer_1.8.5_linux_amd64.zip
RUN unzip packer_1.8.5_linux_amd64.zip
RUN mv packer /usr/local/bin/