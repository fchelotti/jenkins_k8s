FROM python:latest
USER root
ENV DEBIAN_FRONTEND=noninteractive
COPY ./krb5.conf /etc/krb5.conf
COPY ./resolv.conf /etc/resolv.conf
COPY ./ssh_config /etc/ssh/ssh_config
RUN mkdir -p /etc/scripts
COPY ./convert.sh /etc/scripts
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    libkrb5-dev \
    krb5-user \
    iputils-ping \
    vim \
    sshpass \
    openssh-server \
    telnet \
    zip \
 && rm -rf /var/lib/apt/lists/*

RUN wget http://www.rarlab.com/rar/rarlinux-x64-621.tar.gz
RUN tar -xvzf rarlinux-x64-621.tar.gz
RUN mv rar /usr/local/
RUN ln -s /usr/local/rar/unrar /usr/bin/
RUN ln -s /usr/local/rar/rar /usr/bin/

RUN python -m pip install --upgrade pip setuptools wheel
RUN python -m pip install --upgrade pyproject-toml==0.0.10
RUN python -m pip install --upgrade pywinrm[kerberos]
RUN python -m pip install --upgrade pymssql==2.2.7
RUN python -m pip install --upgrade pywinrm==0.4.3
RUN python -m pip install --upgrade requests-kerberos==0.14.0
RUN python -m pip install --upgrade ansible-core==2.13.4
RUN ansible-galaxy collection install ansible.windows
RUN ansible-galaxy collection install community.general
RUN ansible-galaxy collection install microsoft.sql
RUN ansible-galaxy collection install community.windows
RUN ansible-galaxy collection install ansible.windows

RUN mkdir -p /etc/ansible \
 && echo 'localhost' > /etc/ansible/hosts \
 && echo """\
\n\
Host *\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

WORKDIR /ansible
CMD [ "ansible-playbook", "--version" ]