param(
    [string]$AdminWVDUPN,
    [securestring]$AdminWVDPassword
)
$UserObjectId = Get-AzureADUser `
  -Filter "UserPrincipalName eq '$AdminWVDUPN'" | `
  Select-Object ObjectId

Set-AzureADUserPassword -ObjectId  $UserObjectId.ObjectId -Password $AdminWVDPassword
