#!/bin/bash

# install_k8s.sh
# Version: 1.0
# Descripcion: Install Kubernetes and components
# SO: RedHat 8
# Environment: PROD - SUL

### Preparing the environment ###
# Uninstall runc
if [[ $(dnf list installed | grep runc | wc -l) -gt 0 ]]; then
    dnf remove -y runc
else
    echo "runc not installed"
fi

# pre-config containerd
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# pre config kubernetes
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
# Kubernetes
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

cat >> /etc/sysctl.conf <<EOF
# Kubernetes
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

# Install dependencies for kubernetes
for i in yum-utils device-mapper-persistent-data lvm2 iproute; do
    if [[ $(dnf list installed | grep $i | wc -l) -eq 0 ]]; then
        dnf install -y $i
    else
        echo "$i already installed"
    fi
done

# Disable swap
if [[ $(swapon -s | wc -l) -gt 1 ]]; then
    swapoff -a
else
    echo "swap not enabled"
fi

sed -i '/swap/d' /etc/fstab

# Add docker repository
if [[ $(dnf repolist | grep docker | wc -l) -eq 0 ]]; then
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
else
    echo "docker repository already exists"
fi

# Install containerd
if [[ $(dnf list installed | grep containerd | wc -l) -eq 0 ]]; then
    dnf update -y && dnf install -y containerd.io
    systemctl enable containerd
else
    echo "containerd already installed"
fi

# Configure containerd
if [[ ! -d /etc/containerd ]]; then
    mkdir -p /etc/containerd
else
    echo "containerd directory already exists"
fi

containerd config default > /etc/containerd/config.toml

# Configure crictl
if [[ ! -d /etc/crictl ]]; then
    mkdir -p /etc/crictl
else
    echo "crictl directory already exists"
fi

cat > /etc/crictl.yaml <<EOF
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 10
debug: false
EOF


# Restart containerd
systemctl restart containerd

# Add kubernetes repository
if [[ $(dnf repolist | grep kubernetes | wc -l) -eq 0 ]]; then
    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
else
    echo "kubernetes repository already exists"
fi

# Install kubernetes
if [[ $(dnf list installed | grep kubelet | wc -l) -eq 0 ]]; then
    dnf install -y kubeadm-1.24.7 kubelet-1.24.7 kubectl-1.24.7 --disableexcludes=kubernetes
fi

# Enable kubelet
systemctl enable --now kubelet

# Install Helm
if [[ ! -f /usr/local/bin/helm ]]; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    # Create simbolic link Helm
    ln -s /usr/local/bin/helm /usr/bin/helm
else
    echo "Helm already installed"
fi

# configure bash_completion
if [[ ! -f /etc/bash_completion.d/kubectl ]]; then
    kubectl completion bash > /etc/bash_completion.d/kubectl
else
    echo "kubectl bash_completion already configured"
fi

if [[ ! -f /etc/bash_completion.d/helm ]]; then
    helm completion bash > /etc/bash_completion.d/helm
else
    echo "helm bash_completion already configured"
fi

if [[ ! -f /etc/bash_completion.d/kubeadm ]]; then
    kubeadm completion bash > /etc/bash_completion.d/kubeadm
else
    echo "kubeadm bash_completion already configured"
fi

if [[ ! -f /etc/bash_completion.d/crictl ]]; then
    crictl completion bash > /etc/bash_completion.d/crictl
else
    echo "crictl bash_completion already configured"
fi

# Configure bashrc
cat <<EOF >> .bashrc

# Git branch
parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
EOF
