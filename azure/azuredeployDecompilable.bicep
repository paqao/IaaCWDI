@allowed([
  'StorageV2'
  'BlobStorage'
])
param storageKind string
param environmentCode string

var storageAccountName = 'parasomeothernmamepl${toLower(environmentCode)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  location: resourceGroup().location
  name: storageAccountName
  sku: {
    name: 'Standard_LRS'
  }
  kind: storageKind
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource storageAccountName_default_containername 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: '${storageAccountName}/default/containername'
  dependsOn: [
    storageAccount
  ]
}