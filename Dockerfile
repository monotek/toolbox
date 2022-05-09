FROM alpine:3.15.4

ENV HELM_VERSION v3.8.1
ENV KIND_VERSION v0.12.0
ENV KUBECONFORM_VERSION v0.4.13
ENV KUBECTL_VERSION v1.24.0
ENV KUSTOMIZE_VERSION v4.5.4
ENV SOPS_VERSION v3.7.2
ENV TERRAFORM_VERSION 1.1.9
ENV YQ_BIN_VERSION v4.25.1

COPY entrypoint.sh entrypoint.sh
COPY commands.sh /data/commands.sh
COPY install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh && \
    rm /tmp/install.sh

VOLUME /data

USER toolbox

ENTRYPOINT ["/entrypoint.sh"]
