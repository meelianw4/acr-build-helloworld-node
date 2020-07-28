$RES_GROUP = "testacrp-we-rg"
$containerName = "acr-tasks"
$ACR_NAME = "rocontainerregistry001a"
$AKV_NAME="testacrp-kv"
$username = "testacrp-push-usr"
$AKV_PWD = "testacrp-push-pwd"
$dnsLabel = "acr-task-testacrp"

az container create `
    --resource-group $RES_GROUP `
    --name $containerName `
    --image "${ACR_NAME}.azurecr.io/helloacrtasks:v1" `
    --registry-login-server "${ACR_NAME}.azurecr.io" `
    --registry-username $(az keyvault secret show --vault-name $AKV_NAME --name $username --query value -o tsv) `
    --registry-password $(az keyvault secret show --vault-name $AKV_NAME --name $AKV_PWD --query value -o tsv) `
    --dns-name-label $dnsLabel `
    --query "{FQDN:ipAddress.fqdn}" `
    --output table
