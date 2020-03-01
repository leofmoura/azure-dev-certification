$resourceGroupName = "cosmosdb"
$location = "westus"
$accountName= "leo203cosmosdb"
$databaseName = "myDatabase"

az group create `
 -n $resourceGroupName `
 -l $location

# Create a SQL API Cosmos DB account with session consistency and multi-master enabled
az cosmosdb create `
 -g $resourceGroupName `
 --name $accountName `
 --kind GlobalDocumentDB `
 --locations regionName=westus failoverPriority=0 isZoneRedundant=False --locations regionName=eastus2 failoverPriority=1 isZoneRedundant=True `
 --default-consistency-level Strong `
 --enable-multiple-write-locations true `
 --enable-automatic-failover true

# Create a database
az cosmosdb database create `
 -g $resourceGroupName `
 --name $accountName `
 --db-name $databaseName

# List account keys
az cosmosdb keys list `
 --name $accountName `
 -g $resourceGroupName

# List account connection strings
az cosmosdb keys list `
 --name $accountName `
 --type connection-strings `
 -g $resourceGroupName

az cosmosdb show `
 --name $accountName `
 -g $resourceGroupName `
 --query "documentEndpoint"

# Clean up
az group delete -y -g $resourceGroupName
