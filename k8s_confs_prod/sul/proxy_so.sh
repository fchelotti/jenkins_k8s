#!/bin/bash

# proxy_so.sh
# Version: 1.0
# Descripcion: Configuraction proxy for SO
# SO: RedHat 8
# Environment: PROD - SUL

# Config proxy
PROXY_URL="http://10.112.244.74:8080"
SPROXY_URL="http://10.112.244.74:8080"

# Config /etc/profile
tee -a /etc/profile << EOF

### BEGIN - SET PROXY ###
export https_proxy=$PROXY_URL
export http_proxy=$PROXY_URL
export no_proxy=localhost,10.96.0.0/12,192.168.0.0/16,10.112.0.0/16,.svc,10.114.35.202/32,.default,.local,.cluster.local,127.0.0.0/8,10.114.35.202/32
export ftp_proxy=$PROXY_URL
export CONTAINER_RUNTIME_ENDPOINT=unix:///run/containerd/containerd.sock
### END - SET PROXY ###
EOF

# Load /etc/profile
source /etc/profile

echo "Proxy configurated"
