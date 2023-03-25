@secure()
param blobname string
param storageAccountName string

resource someStorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: toLower(storageAccountName)
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: someStorageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobServices
  name: toLower(blobname)
}

output containerId string = container.id
