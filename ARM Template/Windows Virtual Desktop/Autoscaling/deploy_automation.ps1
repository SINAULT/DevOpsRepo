[CmdletBinding()]
param (
    $User,
    $Password,
    $ADTenant,
    $SubscriptionId
)
$UserPassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $UserPassword

Connect-AzAccount -Credential $Credential -Tenant $ADTenant

$Params = @{
     "AADTenantId"           = $ADTenant
     "SubscriptionId"        = $SubscriptionId
     "UseARMAPI"             = $true
     "ResourceGroupName"     = "WEUDSTRSGZZZF00"
     "AutomationAccountName" = "WEUDSTAUTZZZF00"
     "Location"              = "westeurope"
     "WorkspaceName"         = "WEUDSTLOGWVDF00"
}

.\CreateOrUpdateAzAutoAccount.ps1 @Params