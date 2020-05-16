#!/bin/sh

# set -e

# mkdir -p ${HOME}/.kube
# value=`cat .kube/config`
# echo "$value" > ${HOME}/.kube/config
# export KUBECONFIG=${HOME}/.kube/config

# #Setup 

# mkdir -p $HOME/go/src/github.com/uditgaurav
# cd ${GOPATH}/src/github.com/uditgaurav/
# git clone https://github.com/uditgaurav/central-ci.git
# cd central-ci

# #Getting the nodes of the cluster
# kubectl get nodes

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


 
#!/bin/sh

# set -e

##Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ${HOME}/.kube
# cat /home/runner/.kube/config > ${HOME}/.kube/config

echo "$kubeconfig"  | base64 --decode
echo "$kubeconfig"  | base64 --decode > ${HOME}/.kube/config
export KUBECONFIG=${HOME}/.kube/config

# mkdir -p $HOME/.kube
kubectl config use-context docker-for-desktop

##Setup 
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
mkdir -p $HOME/go/src/github.com/mayadata-io
cd ${GOPATH}/src/github.com/mayadata-io/
git clone https://github.com/mayadata-io/chaos-ci-lib.git
cd chaos-ci-lib
echo "Starting experiment"

kubectl get nodes --kubeconfig=$KUBECONFIG

##Install litmus if it is not already installed
if [ $INSTALL_LITMUS = true ]
then
  go test tests/install-litmus_test.go -v -count=1
fi

##Running the selected chaos experiment template
go test tests/${EXPERIMENT_NAME}_test.go -v -count=1

##litmus cleanup
if [ $LITMUS_CLEANUP = true ]
then
  go test tests/uninstall-litmus_test.go -v -count=1
fi
