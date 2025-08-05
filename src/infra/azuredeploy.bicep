# 1. Create Blob (cool tier)
az storage container create \
  --account-name myarchive \
  --name billing-archive

# 2. Create Table for index
az storage table create \
  --account-name mystorage \
  --name BillingIndex

# 3. Deploy Function App (via Bicep or ARM)
# Sample resource snippet:
resource billingArchiveFunction 'Microsoft.Web/sites@2022-03-01' = {
  name: 'billing-archive-func'
  kind: 'functionapp'
  properties: { ... }
}
