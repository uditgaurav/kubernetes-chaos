#!/bin/bash

set -e

TOTAL_CHAOS_DURATION=${TOTAL_CHAOS_DURATION:=60}
TEST_TIMEOUT=$((900 + $TOTAL_CHAOS_DURATION))
PARALLEL_EXECUTION=${PARALLEL_EXECUTION:=1}

## Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ${HOME}/.kube
echo "$KUBE_CONFIG_DATA" | base64 --decode > ${HOME}/.kube/config
export KUBECONFIG=${HOME}/.kube/config

## Setup 
mkdir -p $HOME/go/src/github.com/mayadata-io
cd ${GOPATH}/src/github.com/mayadata-io/
dir=${GOPATH}/src/github.com/mayadata-io/chaos-ci-lib

if [ ! -d $dir ]; then
# git clone -b v0.1.0 --single-branch  https://github.com/mayadata-io/chaos-ci-lib.git
git clone https://github.com/uditgaurav/chaos-ci-lib.git
fi
cd chaos-ci-lib

## Install litmus if it is not already installed
if [ "$INSTALL_LITMUS" = "true" ]; then
  cd litmus
  go test install-litmus_test.go -v -count=1 
fi

if [ "$EXPERIMENT_NAME" == "all" ]; then
## Run all BDDs 
cd tests
ginkgo -nodes=${PARALLEL_EXECUTION}

else
## Run the selected chaos experiment template
cd ..
go test tests/${EXPERIMENT_NAME}_test.go -v -count=1 -timeout=${TEST_TIMEOUT}s
fi

## Litmus cleanup
if [ "$LITMUS_CLEANUP" = "true" ]; then
  go test litmus/uninstall-litmus_test.go -v -count=1
fi
