FROM jenkins/jnlp-slave:alpine
USER root
RUN apk --update --no-cache add curl redis jq
RUN wget https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip
RUN unzip terraform_1.2.9_linux_amd64.zip
RUN mv terraform /usr/local/bin/