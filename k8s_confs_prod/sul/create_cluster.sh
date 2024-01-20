#!/bin/bash

# create_cluster.sh
# Version: 1.0
# Descripcion: create k8s cluster
# SO: RedHat 8
# Environment: PROD - SUL

### Preparing the environment ###
# Configure hosts

cat >> /etc/hosts <<EOF
# K8s
10.0.0.1 [informe o hostname1]
10.0.0.2 [informe o hostname2]
10.0.0.3 [informe o hostname3]
10.0.0.4 [informe o hostname4]
10.0.0.5 [informe o hostname5]
EOF


# Configure K8s Cluster
if [ hostname -eq "hostname1" ]; then
  kubeadm init --control-plane-endpoint "10.0.0.1:6443" --upload-certs --apiserver-cert-extra-sans=10.104.244.201 --pod-network-cidr=192.168.0.0/24
fi

# Install a network plugin for pod communication (e.g., Calico)
if [ hostname -eq "hostname1" ]; then
  kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
fi
