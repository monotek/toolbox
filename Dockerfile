FROM alpine:3.21.0

ENV CUELANG_VERSION v0.7.0
ENV HELM_VERSION v3.13.2
ENV KIND_VERSION v0.20.0
ENV KUBECONFORM_VERSION v0.6.4
ENV KUBECTL_VERSION v1.28.6
ENV KUSTOMIZE_VERSION v5.3.0
ENV SOPS_VERSION v3.8.0
ENV TERRAFORM_VERSION 1.7.0
ENV YQ_BIN_VERSION v4.40.5

WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
COPY commands.sh /data/commands.sh
COPY install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh && \
    rm /tmp/install.sh

VOLUME /data

USER toolbox

#checkov:skip=CKV_DOCKER_2:We don't need Docker HEALTHCHECK in Kubernetes

ENTRYPOINT ["/entrypoint.sh"]
