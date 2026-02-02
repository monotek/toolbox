FROM alpine:3.23.3

ENV KUBECONFORM_VERSION=v0.7.0
ENV SOPS_VERSION=v3.11.0
ENV TERRAFORM_VERSION=1.14.0

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
