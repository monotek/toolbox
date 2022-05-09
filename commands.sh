#!/usr/bin/env sh

echo " -------------- "
echo "| HELM VERSION |"
echo " -------------- "
helm version
echo ""

echo " ---------------"
echo "| KIND VERSION |"
echo " ---------------"
kind version
echo ""

echo " ------------------------ "
echo "| KUBECTL CLIENT VERSION |"
echo " ------------------------ "
kubectl version --client
echo ""

echo " --------------------- "
echo "| KUBECONFORM VERSION |"
echo " --------------------- "
echo "${KUBECONFORM_VERSION}"
echo ""

echo " ------------------- "
echo "| KUSTOMIZE VERSION |"
echo " ------------------- "
kustomize version
echo ""

echo " -------------- "
echo "| SOPS VERSION |"
echo " -------------- "
sops -v
echo ""

echo " ------------------- "
echo "| TERRAFORM VERSION |"
echo " ------------------- "
terraform version
echo ""

echo " ------------ "
echo "| YQ VERSION |"
echo " ------------ "
yq -V
echo ""

echo " ====================== "
echo ""
echo "To run a custom script, just mount it '--volume /your/script.sh:/data/commands.sh:ro'"
echo ""
