param(
  [string]$UserAD,
  [securestring]$UserPassword,
  [string]$AADTenant
)

$CredentialAD = New-Object System.Management.Automation.PSCredential($UserAD,$UserPassword)

Connect-AzureAD -TenantId $AADTenant -Credential $CredentialAD

###################################Creation Group############################################

New-AzureADGroup -DisplayName "GS_WVD_Users" `
  -Description "Delegated group to user Windows Virtual Desktop" `
  -SecurityEnabled $true -MailEnabled $false `
  -MailNickName "GS_WVD_Users"

$GroupObjectId = Get-AzureADGroup `
-Filter "DisplayName eq 'GS_WVD_Users'" | `
 Select-Object ObjectId

###############################Creation Azure User###########################################
################################Add User to Group############################################


$file = "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\UserManagement\WVDUsers.csv"
$CSVdata = Import-Csv -path $file

foreach ($user in $CSVdata)
{
    $UPN = $user.UserPrincipalName 
    write-host "($i)_.Creating User:" $UPN -f DarkYellow
    
    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = $user.PasswordProfile

    New-AzureADUser -DisplayName $user.DisplayName `
        -PasswordProfile $PasswordProfile `
        -UserPrincipalName $user.UserPrincipalName `
        -MailNickName $user.MailNickName `
        -AccountEnabled $true
    
    # Now, retrieve the object ID of the user you'd like to add to the group.
    $UserObjectId = Get-AzureADUser `
    -Filter "UserPrincipalName eq '$UPN'" | `
    Select-Object ObjectId

    # Add the user to the 'GS_ADDS_Users' group.
    Add-AzureADGroupMember -ObjectId $GroupObjectId.ObjectId -RefObjectId $UserObjectId.ObjectId

}