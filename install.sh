 #!/usr/bin/env sh

set -ex

# install apk packages
apk update 
apk --no-cache upgrade
apk --no-cache add ca-certificates curl helm kind kubectl kustomize libcap openssh openssl jq rsync util-linux-misc yq-go

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

# install kubeconform
curl --silent --show-error --fail --location --output /tmp/kubeconform.tar.gz https://github.com/yannh/kubeconform/releases/download/"${KUBECONFORM_VERSION}"/kubeconform-linux-"${ARCH}".tar.gz
tar -C /usr/local/bin -xf /tmp/kubeconform.tar.gz kubeconform
rm /tmp/kubeconform.tar.gz

# install sops
curl --silent --show-error --fail --location --output /usr/local/bin/sops https://github.com/getsops/sops/releases/download/"${SOPS_VERSION}"/sops-"${SOPS_VERSION}".linux."${ARCH}"
chmod 755 /usr/local/bin/sops

# install terraform
curl --silent --show-error --fail --location --output /tmp/terraform.zip https://releases.hashicorp.com/terraform/"${TERRAFORM_VERSION}"/terraform_"${TERRAFORM_VERSION}"_linux_"${ARCH}".zip
unzip /tmp/terraform.zip -d /usr/local/bin
rm /tmp/terraform.zip

# set permissions
mkdir -p /data
chown toolbox /data /entrypoint.sh /data/commands.sh
chmod +x /entrypoint.sh /data/commands.sh
