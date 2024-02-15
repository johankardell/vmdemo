az group create --name vmdemo3 --location swedencentral
az deployment group create -g vmdemo3 --template-file vm.bicep --parameters vm.bicepparam
