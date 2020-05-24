FROM golang:latest

LABEL version="1.0.0"
LABEL name="MyChaos"
LABEL repository="http://github.com/uditgaurav/k8s-actions"
LABEL homepage="http://github.com/uditgaurav/k8s-actions"

LABEL maintainer="Udit Gaurav <uditgaurav@gmail.com>"
LABEL com.github.actions.name="Kubernetes Pod Delete"
LABEL com.github.actions.description="Runs kubectl delete pod on a given namespace and name of pod. The config can be provided with the secret KUBE_CONFIG_DATA."
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"

ENV GOPATH=/github/home/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

ARG KUBECTL_VERSION=1.17.0
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y ssh 
RUN apt install ssh rsync

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh
COPY experiments ./experiments

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
