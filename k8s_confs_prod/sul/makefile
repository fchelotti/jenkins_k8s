all: help

help:
	@echo Configuring proxy for server and installing kubernetes
	@echo 
	@echo Usage:
	@echo '	make proxy				= configure proxy for server'
	@echo '	make no_proxy				= configure no proxy for server'
	@echo '	make install_k8s			= install kubernetes in server'
	@echo '	make create_cluster			= create cluster in server'
	@echo '	make build				= configure proxy, no proxy and install kubernetes'
	@echo

build: proxy no_proxy install_k8s create_cluster
proxy: configure_proxy
no_proxy: configure_no_proxy
install_k8s: install_k8s
create_cluster: create_cluster

configure_proxy:
	@echo "Configuring proxy"
	sh proxy_so.sh

configure_no_proxy:
	@echo "Configuring no proxy"
	sh no_proxy_services.sh

install_k8s:
	@echo "Installing kubernetes"
	sh install_k8s.sh

create_cluster:
	@echo "Creating cluster"
	sh create_cluster.sh
