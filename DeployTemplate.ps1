$ACR_NAME = "rocontainerregistry001a"
$AKV_NAME="testacrp-kv"
$RES_GROUP = "testacrp-we-rg"
$AKV_PWD = "testacrp-push-pwd"
$AKV_PUSH = "testacrp-push"

# Create service principal, store its password in AKV (the registry *password*)
az keyvault secret set `
  --vault-name $AKV_NAME `
  --name $AKV_PWD `
  --value $(az ad sp create-for-rbac `
                --name $AKV_PUSH `
                --scopes $(az acr show --name $ACR_NAME --query id --output tsv) `
                --role acrpush `
                --query password `
                --output tsv)

# Store service principal ID in AKV (the registry *username*)
$username = "testacrp-push-usr"
az keyvault secret set `
--vault-name $AKV_NAME `
--name $username `
--value $(az ad sp show --id "http://${AKV_PUSH}" --query appId --output tsv)
