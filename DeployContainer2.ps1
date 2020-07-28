$RES_GROUP = "testacrp-we-rg"
$containerName = "taskhelloworld1"
$ACR_NAME = "rocontainerregistry001a"
$AKV_NAME="testacrp-kv"
$username = "testacrp-push-usr"
$AKV_PWD = "testacrp-push-pwd"
$dnsLabel = "acr-task-testacrp"

$GIT_USER="meelianw4"
$GIT_PAT="cd47594f75b77849fb2e1cb7d64c5fb673f50cea"
$dockerFilename = "Dockerfile-app"

az acr build --registry $ACR_NAME --image baseimages/node:9-alpine --file Dockerfile-base .

az acr task create `
    --registry $ACR_NAME `
    --name taskhelloworld `
    --image helloworld:{{.Run.ID}} `
    --arg REGISTRY_NAME=$ACR_NAME.azurecr.io `
    --context https://github.com/$GIT_USER/acr-build-helloworld-node.git `
    --file Dockerfile-app `
    --git-access-token $GIT_PAT
