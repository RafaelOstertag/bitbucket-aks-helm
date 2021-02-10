#!/bin/bash

trap '{ rm -f .kube/kubeconfig; }' EXIT

set -eu
: ${AZURE_APP_ID:=}
: ${AZURE_PASSWORD:=}
: ${AZURE_TENANT_ID:=}
: ${AZURE_RESOURCE_GROUP:=}
: ${AZURE_AKS_NAME:=}
: ${HELM_RELEASE_NAME:=}
: ${HELM_CHART_DIR:=}
: ${HELM_COMMAND_ARGS:=}

require_var_set() {
    local name=$1

    if [ -z "$(eval echo $`echo ${name}`)" ]
    then
        echo "Required variable '$name' not set" >&2
        exit 1
    fi
}

for v in "AZURE_APP_ID" "AZURE_PASSWORD" "AZURE_TENANT" "AZURE_RESOURCE_GROUP" "AZURE_AKS_NAME" "HELM_RELEASE_NAME" "HELM_CHART_DIR" "HELM_COMMAND_ARGS"
do
    require_var_set "$v"
done

az login --service-principal --username "$AZURE_APP_ID" --password "$AZURE_PASSWORD" --tenant "$AZURE_TENANT_ID"
az aks get-credentials --resource-group "$AZURE_RESOURCE_GROUP" --name "$AZURE_AKS_NAME" --file .kube/kubeconfig --overwrite-existing
helm --kubeconfig .kube/kubeconfig upgrade -i $HELM_COMMAND_ARGS "$HELM_RELEASE_NAME" "${HELM_CHART_DIR}"
