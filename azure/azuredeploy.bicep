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

module someDefaultBlob 'modules/addblob.bicep' = {
  name: 'defaultBlob'
  params: {
    blobname: 'default'
    storageAccountName: someStorageAccount.name 
  }
}


module someOtherBlob 'modules/addblob.bicep' = {
  name: 'otherBlob'
  params: {
    blobname: 'other'
    storageAccountName: someStorageAccount.name
  }
}
