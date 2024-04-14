# Cluster

Install and bootstrap a K8s cluster, regardless of what kind. Will provide some default solutions
to deal with testing K8s resources.

## Requirements
```
* bash
* kubectl
* helm v2
* docker
* docker-compose
```

## Components

```
* K3S
* NGINX Ingress
```

## Quickstart

### Install

Default is to use a K3S cluster, but you can skip this step and use a different one.
The only requirement is that you can install another Ingress Controller and have a default Storage Class.
```shell
./install.sh
```


### Bootstrap

This script will assume that you have a K8s cluster ready to add an ingress and your kubectl configured to access it.
Additionally, it will add a TCP proxy to the cluster so your localhost will go directly to the node IP for the http,https and ssh ports.

```shell
./bootstrap.sh
```

### [Ingress Controller](ingress_controller/install.sh)
Will install the NGINX ingress controller


### [Traffic Proxy](traffic/install.sh)
Will set up some docker containers to proxy the tcp connections from your localhost to the loadbalancer IP of the ingress NGINX. 

### [Cert Manager](cert_manager)
Will install cert manager for creating certificates. Will come WITHOUT a cluster issuer. 
Adding Wildcard cert for ingress to use as default
They are highly individual therefore I didn't go through the