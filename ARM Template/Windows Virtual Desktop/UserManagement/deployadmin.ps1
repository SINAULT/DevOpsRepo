param(
  [string]$UserAD,
  [securestring]$UserPassword,
  [string]$AADTenant,
  [string]$Subscription,
  [string]$AdminWVD,
  [securestring]$AdminWVDPassword,
  [string]$AdminWVDUPN
)

$subscriptionScope = '/subscriptions/'+$Subscription
$CredentialAD = New-Object System.Management.Automation.PSCredential($UserAD,$UserPassword)

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile($AdminWVDPassword)

Connect-AzureAD -TenantId $AADTenant -Credential $CredentialAD

New-AzureADGroup -DisplayName "AAD DC Administrators" `
  -Description "Delegated group to administer Azure AD Domain Services" `
  -SecurityEnabled $true -MailEnabled $false `
  -MailNickName "AADDCAdministrators"


New-AzureADUser -DisplayName $AdminWVD `
  -PasswordProfile $PasswordProfile `
  -MailNickName $AdminWVD `
  -UserPrincipalName $AdminWVDUPN `
  -AccountEnabled $true

# First, retrieve the object ID of the newly created 'AAD DC Administrators' group.
$GroupObjectId = Get-AzureADGroup `
  -Filter "DisplayName eq 'AAD DC Administrators'" | `
  Select-Object ObjectId

# Now, retrieve the object ID of the user you'd like to add to the group.
$UserObjectId = Get-AzureADUser `
  -Filter "UserPrincipalName eq '$AdminWVDUPN'" | `
  Select-Object ObjectId

# Add the user to the 'AAD DC Administrators' group.
Add-AzureADGroupMember -ObjectId $GroupObjectId.ObjectId -RefObjectId $UserObjectId.ObjectId

# Add the user to the app role.

$app_name = "Windows Virtual Desktop"
$app_role_name = "TenantCreator"

$user = Get-AzureADUser -ObjectId "$AdminWVDUPN"
$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
$appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }

New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId `
  -PrincipalId $user.ObjectId `
  -ResourceId $sp.ObjectId `
  -Id $appRole.Id

New-AzRoleAssignment -SignInName $AdminWVDUPN `
  -RoleDefinitionName "Contributor" `
  -Scope $subscriptionScope