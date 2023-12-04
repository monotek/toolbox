FROM alpine:3.18.5

ENV HELM_VERSION v3.12.2
ENV KIND_VERSION v0.20.0
ENV KUBECONFORM_VERSION v0.6.3
ENV KUBECTL_VERSION v1.27.4
ENV KUSTOMIZE_VERSION v5.1.1
ENV SOPS_VERSION v3.7.3
ENV TERRAFORM_VERSION 1.5.4
ENV YQ_BIN_VERSION v4.34.2

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
