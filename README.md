
## Description

This project is a proof of concept to deploy a Jenkins server in a Kubernetes cluster using Helm charts and Jenkins Kubernetes plugin.
This project try to solve the problem of the Operational team to deploy applications like Tomcat, JBoss, execution of scripts SQL in databases and deploy VMs in vSphere.

The project has of the base the principles of the DevOps culture, the Continuous Integration and Continuous Delivery and CNCF tools.

## Requirements

* Kubernetes cluster
* Kubernetes Longhorn
* Kubernetes Nginx Ingress Controller
* Kubernetes MetalLB
* Helm
* Jenkins
* Jenkins plugins
* Jenkins Pipeline
* Docker Build and Publish (To build and publish Docker images)
* Ansible
* Terraform
* SonarQube
* Python

All the docker images are in the Docker Hub repository. The images are:

* Jenkins: jenkins/jenkins:2.401.2-lts-jdk11
* SonarQube: jenkins/jnlp-slave:alpine
* Ansible: python:latest
* Terraform: jenkins/jnlp-slave:alpine
* Python: python:alpine3.17

## Installation

### Kubernetes cluster

The Kubernetes cluster is deployed in the vSphere environment. The cluster has 3 nodes with 2 CPUs and 4 GB of RAM each one in development environment.

In this repo you can find the scripts to deploy configure the cluster in the folder k8s_confs_dev for two environments sul and north. The scripts are:

* create_cluster.sh: Create the cluster
* install_k8s.sh: Install Kubernetes and requimentes in the cluster
* proxy_so.sh: Configure the proxy in the nodes
* no_proxy_services.sh: Configure the no proxy in the nodes

The way easyer to execute the scripts follwing the order is using the makefile. The makefile has the following commands:

* make proxy: Configure the proxy in the nodes
* make no_proxy: Configure the no proxy in the nodes
* make install_k8s: Install Kubernetes and requimentes in the cluster
* make create_cluster: Create the cluster
* make build: Execute all the scripts in the correct order
* make: Show the help

