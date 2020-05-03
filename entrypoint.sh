#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

# ##Install litmus if it is not already installed
# if [ $INSTALL_LITMUS = true ]
# then
#   sh /litmus/installation.sh
# fi

##Select an experiment 
if [ $EXPERIMENT_NAME = "pod-delete" ]
then
  git clone https://github.com/uditgaurav/central-ci.git
  go test central-ci/tests/${EXPERIMENT_NAME}_test.go -v -count=1

fi

# ##litmus cleanup
# if [ $LITMUS_CLEANUP = true ]
# then
#   sh /litmus/cleanup.sh
# fi
