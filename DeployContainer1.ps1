$RES_GROUP = "testacrp-we-rg"
$containerName = "taskhelloworld"
$ACR_NAME = "rocontainerregistry001a"
$AKV_NAME="testacrp-kv"
$username = "testacrp-push-usr"
$AKV_PWD = "testacrp-push-pwd"
$dnsLabel = "acr-task-testacrp"

$GIT_USER="meelianw4"
$GIT_PAT="cd47594f75b77849fb2e1cb7d64c5fb673f50cea"
$context = "https://github.com/${GIT_USER}/acr-build-helloworld-node.git"
$dockerFilename = "Dockerfile"

#az acr build --registry $ACR_NAME --image helloacrtasks:v1 .

az acr task create `
    --registry $ACR_NAME `
    --name $containerName  `
    --image helloworld:{{.Run.ID}} `
    --context https://github.com/$GIT_USER/acr-build-helloworld-node.git `
    --file $dockerFilename `
    --git-access-token $GIT_PAT
