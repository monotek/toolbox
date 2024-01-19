#!/usr/bin/env sh

set -ex

# install apk packages
apk update 
apk --no-cache upgrade
apk --no-cache add ca-certificates curl libcap openssh openssl jq rsync util-linux-misc

# add toolbox user
adduser -S toolbox toolbox

if [ "$(lscpu | grep Architecture | awk '{print $2}')" = "aarch64" ]; then
    ARCH=arm64
else
    ARCH=amd64
fi

# install cuelang
curl --silent --show-error --fail --location --output /tmp/cue.tar.gz https://github.com/cue-lang/cue/releases/download/"${CUELANG_VERSION}"/cue_"${CUELANG_VERSION}"_linux_"${ARCH}".tar.gz
tar -C /usr/local/bin -xf /tmp/cue.tar.gz cue
rm /tmp/cue.tar.gz

# install helm
curl --silent --show-error --fail --location --output /tmp/helm.tar.gz https://get.helm.sh/helm-"${HELM_VERSION}"-linux-"${ARCH}".tar.gz
mkdir /tmp/helm
tar -C /tmp/helm -xf /tmp/helm.tar.gz
cp /tmp/helm/linux-"${ARCH}"/helm /usr/local/bin/helm
rm -rf /tmp/helm.tar.gz /tmp/helm

# install kind
curl --silent --show-error --fail --location --output /usr/local/bin/kind https://kind.sigs.k8s.io/dl/"${KIND_VERSION}"/kind-linux-"${ARCH}"
chmod 755 /usr/local/bin/kind

# install kubeconform
curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz https://github.com/yannh/kubeconform/releases/download/"${KUBECONFORM_VERSION}"/kubeconform-linux-"${ARCH}".tar.gz
tar -C /usr/local/bin -xf /tmp/kubeconform.tar.gz kubeconform
rm /tmp/kubeconform.tar.gz

# install kubectl
curl --silent --show-error --fail --location --output /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/"${KUBECTL_VERSION}"/bin/linux/"${ARCH}"/kubectl
chmod 755 /usr/local/bin/kubectl

# install kustomize
curl --silent --show-error --fail --location --output /tmp/kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F"${KUSTOMIZE_VERSION}"/kustomize_"${KUSTOMIZE_VERSION}"_linux_"${ARCH}".tar.gz
tar -C /usr/local/bin -xf /tmp/kustomize.tar.gz kustomize
#chmod 755 /usr/local/bin/kustomize
rm /tmp/kustomize.tar.gz

# install sops
curl --silent --show-error --fail --location --output /usr/local/bin/sops https://github.com/getsops/sops/releases/download/"${SOPS_VERSION}"/sops-"${SOPS_VERSION}".linux."${ARCH}"
chmod 755 /usr/local/bin/sops

# install terraform
curl --silent --show-error --fail --location --output /tmp/terraform.zip https://releases.hashicorp.com/terraform/"${TERRAFORM_VERSION}"/terraform_"${TERRAFORM_VERSION}"_linux_"${ARCH}".zip
unzip /tmp/terraform.zip -d /usr/local/bin
rm /tmp/terraform.zip

# install yq
curl --silent --show-error --fail --location --output /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/"${YQ_BIN_VERSION}"/yq_linux_"${ARCH}"
chmod 755 /usr/local/bin/yq

# set permissions
mkdir -p /data
chown toolbox /data /entrypoint.sh /data/commands.sh
chmod +x /entrypoint.sh /data/commands.sh
