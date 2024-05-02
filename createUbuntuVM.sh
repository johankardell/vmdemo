export RANDOM_ID="$(openssl rand -hex 3)"
export RANDOM_ID2="$(openssl rand -hex 3)"
export MY_RESOURCE_GROUP_NAME="rg-ubuntudemo-$RANDOM_ID"
export REGION=SwedenCentral
export MY_VM_NAME="myVM$RANDOM_ID"
export MY_VM_NAME2="myVM$RANDOM_ID2"
export MY_USERNAME=azureuser
export MY_VM_IMAGE="Canonical:0001-com-ubuntu-minimal-jammy:minimal-22_04-lts-gen2:latest"

az group create --name $MY_RESOURCE_GROUP_NAME --location $REGION
az vm create \
    --resource-group $MY_RESOURCE_GROUP_NAME \
    --name $MY_VM_NAME \
    --image $MY_VM_IMAGE \
    --admin-username $MY_USERNAME \
    --assign-identity \
    --generate-ssh-keys \
    --public-ip-sku Standard \
    --zone 2

az vm create \
    --resource-group $MY_RESOURCE_GROUP_NAME \
    --name $MY_VM_NAME2 \
    --image $MY_VM_IMAGE \
    --admin-username $MY_USERNAME \
    --assign-identity \
    --generate-ssh-keys \
    --public-ip-sku Standard \
    --zone 2

az vm extension set --resource-group $MY_RESOURCE_GROUP_NAME --vm-name $MY_VM_NAME --name AADSSHLoginForLinux --publisher Microsoft.Azure.ActiveDirectory --version 1.0
az vm extension set --resource-group $MY_RESOURCE_GROUP_NAME --vm-name $MY_VM_NAME2 --name AADSSHLoginForLinux --publisher Microsoft.Azure.ActiveDirectory --version 1.0

az ssh vm --resource-group $MY_RESOURCE_GROUP_NAME --vm-name $MY_VM_NAME --local-user azureuser

az group delete --name $MY_RESOURCE_GROUP_NAME
