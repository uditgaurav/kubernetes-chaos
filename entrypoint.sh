#!/bin/sh

# set -e

mkdir -p ${HOME}/.kube
KUBE_CONFIG_DATA=$(<.kube/config)
echo "$KUBE_CONFIG_DATA" > ${HOME}/.kube/config
export KUBECONFIG=${HOME}/.kube/config

echo "****************Echoing kube config**********************"
echo "$KUBECONFIG"
echo "****************Echoing kube data**********************"
echo "$KUBE_CONFIG_DATA"
echo "****************Echoing kubectl get no**********************"
kubectl get nodes
#Setup 
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
mkdir -p $HOME/go/src/github.com/uditgaurav
rsync -az --delete ${GOPATH}/src/github.com/uditgaurav/
cd ${GOPATH}/src/github.com/uditgaurav/
git clone https://github.com/uditgaurav/central-ci.git
cd central-ci
echo "****************Echoing kubectl get no**********************"
pwd
echo "****************Echoing kubectl get node again**********************"
kubectl get nodes

# ##Install litmus if it is not already installed
# if [ $INSTALL_LITMUS = true ]
# then
#   go test tests/install-litmus_test.go -v -count=1
# fi

# ##Running the chaos experiment template
# go test tests/${EXPERIMENT_NAME}_test.go -v -count=1

# ##litmus cleanup
# if [ $LITMUS_CLEANUP = true ]
# then
#   go test tests/uninstall-litmus_test.go -v -count=1
# fi
