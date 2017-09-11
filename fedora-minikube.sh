#!/bin/bash
#    This is a short repo to experiment with Kubernetes (Using minikube) on Fedora.
#    Copyright (C) 2017  Carlos Eduardo Arango arangogutierrez@gmail.com
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Installing the virtualization packages
sudo dnf install @virtualization
sudo dnf groupinstall virtualization
sudo systemctl start libvirtd
echo $'start the service on boot:'
sudo systemctl enable libvirtd
## Verify that the kvm kernel modules were properly loaded:
echo $'Verifying that the kvm kernel modules were properly loaded:'
lsmod | grep kvm

# Install Docker machine
if [ ! -F /usr/local/bin/docker-machine ]; then
echo $'Installing Docker machine'
curl -L https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
else
  echo $'Docker machine already installed moving to next step...'
fi

# Install docker-machine-driver-kvm
if [ ! -F /usr/local/bin/docker-machine-driver-kvm ]; then
echo $'Installing docker-machine-driver-kvm\n'
$ curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 >/tmp/docker-machine-driver-kvm
$ chmod +x /tmp/docker-machine-driver-kvm
$ sudo cp /tmp/docker-machine-driver-kvm /usr/local/bin/docker-machine-driver-kvm
else
  echo $'docker-machine-driver-kvm already installed moving to next step...'
fi
# Install minikube
if [ ! -F /usr/local/bin/minikube ]; then
echo $'Installing minikube\n'
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 >/tmp/minikube \
 && chmod +x /tmp/minikube \
 && sudo cp /tmp/minikube /usr/local/bin/
else
  echo $'minikube already installed moving to next step...'
fi
 # Install the kubectl
if [ ! -F /usr/local/bin/kubectl ]; then
 echo $'Installing kubectl\n'
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x kubectl \
 && sudo mv kubectl /usr/local/bin/
else
  echo $'kubectl already installed moving to next step...'
fi
# Create the Minikube cluster
export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true

if [ ! -F $HOME/.kube/config ]; then
 echo $'Installing kubectl\n'
mkdir $HOME/.kube || true
touch $HOME/.kube/config
fi

export KUBECONFIG=$HOME/.kube/config
sudo -E ./minikube start --vm-driver=none

# this for loop waits until kubectl can access the api server that minikube has created
for i in {1..150} # timeout for 5 minutes
do
   ./kubectl get po &> /dev/null
   if [ $? -ne 1 ]; then
      break
  fi
  sleep 2
done

# kubectl commands are now able to interact with minikube cluster
# EOF!
