# Fedora-Minikube
This is a short repo to experiment with Kubernetes (Using minikube) on Fedora.
This is just an automated way to install and set up a Minikube following the instructions on the [**MiniKube oficial repo**](https://github.com/kubernetes/minikube)

## What is Minikube?

Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

## Install MiniKube on Fedora

### Pre-requirements
To install minikube you will first need
 - [Docker-ce Fedora install](https://docs.docker.com/engine/installation/linux/docker-ce/fedora/)

### Installing
first clone the repo and enter to the repo folder
```bash
git clone https://github.com/ArangoGutierrez/Fedora-Minikube.git
cd Fedora-Minikube
```
Then run
```bash
./fedora-minikube.sh
```
## Additional Links:
* [**MiniKube oficial repo**](https://github.com/kubernetes/minikube)
* [**Advanced Topics and Tutorials**](https://github.com/kubernetes/minikube/blob/master/docs/README.md)
* [**Contributing**](https://github.com/kubernetes/minikube/blob/master/CONTRIBUTING.md)
* [**Development Guide**](https://github.com/kubernetes/minikube/blob/master/docs/contributors/README.md)

## Community

* [**#minikube on Kubernetes Slack**](https://kubernetes.slack.com)
* [**kubernetes-dev mailing list** ](https://groups.google.com/forum/#!forum/kubernetes-dev)
