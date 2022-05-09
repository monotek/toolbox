#!/usr/bin/env sh

set -ex

# add gkh user
adduser -S toolbox toolbox

# install apk packages
apk --no-cache add ca-certificates curl openssl jq

# install helm
curl --silent --show-error --fail --location --output /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
mkdir /tmp/helm
tar -C /tmp/helm -xf /tmp/helm.tar.gz
cp /tmp/helm/linux-amd64/helm /usr/local/bin/helm
#chmod 755 /usr/local/bin/helm
rm -rf /tmp/helm.tar.gz /tmp/helm

# install kind
curl --silent --show-error --fail --location --output /usr/local/bin/kind https://kind.sigs.k8s.io/dl/"${KIND_VERSION}"/kind-linux-amd64
chmod 755 /usr/local/bin/kind

# install kubeconform
curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz https://github.com/yannh/kubeconform/releases/download/"${KUBECONFORM_VERSION}"/kubeconform-linux-amd64.tar.gz
tar -C /usr/local/bin -xf /tmp/kubeconform.tar.gz kubeconform
rm /tmp/kubeconform.tar.gz

# install kubectl
curl --silent --show-error --fail --location --output /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/"${KUBECTL_VERSION}"/bin/linux/amd64/kubectl
chmod 755 /usr/local/bin/kubectl

# install kustomize
curl --silent --show-error --fail --location --output /tmp/kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F"${KUSTOMIZE_VERSION}"/kustomize_"${KUSTOMIZE_VERSION}"_linux_amd64.tar.gz
tar -C /usr/local/bin -xf /tmp/kustomize.tar.gz kustomize
#chmod 755 /usr/local/bin/kustomize
rm /tmp/kustomize.tar.gz

# install sops
curl --silent --show-error --fail --location --output /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/"${SOPS_VERSION}"/sops-"${SOPS_VERSION}".linux
chmod 755 /usr/local/bin/sops

# install terraform
curl --silent --show-error --fail --location --output /tmp/terraform.zip https://releases.hashicorp.com/terraform/"${TERRAFORM_VERSION}"/terraform_"${TERRAFORM_VERSION}"_linux_amd64.zip
unzip /tmp/terraform.zip -d /usr/local/bin
rm /tmp/terraform.zip

# install yq
curl --silent --show-error --fail --location --output /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/"${YQ_BIN_VERSION}"/yq_linux_amd64
chmod 755 /usr/local/bin/yq

# set permissions
mkdir -p /data
chown toolbox /data /entrypoint.sh /data/commands.sh
chmod +x /entrypoint.sh /data/commands.sh
