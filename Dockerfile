FROM alpine:3.17.0

ENV HELM_VERSION v3.10.3
ENV KIND_VERSION v0.17.0
ENV KUBECONFORM_VERSION v0.5.0
ENV KUBECTL_VERSION v1.26.0
ENV KUSTOMIZE_VERSION v4.5.7
ENV SOPS_VERSION v3.7.3
ENV TERRAFORM_VERSION 1.3.7
ENV YQ_BIN_VERSION v4.30.8

WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
COPY commands.sh /data/commands.sh
COPY install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh && \
    rm /tmp/install.sh

VOLUME /data

USER toolbox

ENTRYPOINT ["/entrypoint.sh"]
