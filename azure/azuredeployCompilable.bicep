param location string = resourceGroup().location
param environmentCode string

@allowed([
  'StorageV2'
  'BlobStorage'
])
param storageKind string

resource someStorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'pl${toLower(environmentCode)}saneu'
  kind: storageKind
  location: location
  sku: {
    name: 'Standard_LRS'
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: someStorageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobServices
  name: 'othername'
}
