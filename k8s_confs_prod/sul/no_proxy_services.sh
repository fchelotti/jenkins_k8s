#!/bin/bash

# no_proxy_services.sh
# Version: 1.0
# Descripcion: Configuraction no_proxy for services
# SO: RedHat 8
# Environment: PROD - SUL

# Config /etc/systemd/system.conf.d/proxy.conf
mkdir -p /etc/systemd/system.conf.d
tee -a /etc/systemd/system.conf.d/proxy.conf << EOF
[Manager]
Environment="HTTPS_PROXY=http://10.112.244.74:8080"
Environment="HTTP_PROXY=http://10.112.244.74:8080"
Environment="no_proxy=localhost,10.96.0.0/12,192.168.0.0/16,10.112.0.0/16,.svc,10.114.35.202/32,.default,.local,.cluster.local,127.0.0.0/8,10.114.35.202/32"
Environment="NO_PROXY=localhost,10.96.0.0/12,192.168.0.0/16,10.112.0.0/16,.svc,10.114.35.202/32,.default,.local,.cluster.local,127.0.0.0/8,10.114.35.202/32"
EOF

# Configure containerd
proxy_lines='Environment=no_proxy=localhost,10.96.0.0/12,192.168.0.0/16,10.112.0.0/16,.svc,10.114.35.202/32,.default,.local,.cluster.local,127.0.0.0/8,10.114.35.202/32\nEnvironment=NO_PROXY=localhost,10.96.0.0/12,192.168.0.0/16,10.112.0.0/16,.svc,10.114.35.202/32,.default,.local,.cluster.local,127.0.0.0/8,10.114.35.202/32'

sed -i "/ExecStart=/a $proxy_lines" /etc/systemd/system/multi-user.target.wants/containerd.service
sed -i "/ExecStart=/a $proxy_lines" /etc/systemd/system/multi-user.target.wants/kubelet.service

# Reload systemd
systemctl daemon-reload

# Restart containerd and kubelet
systemctl restart containerd
systemctl restart kubelet


# Show systemd environment
systemctl show-environment

echo "Proxy configurated for Services"