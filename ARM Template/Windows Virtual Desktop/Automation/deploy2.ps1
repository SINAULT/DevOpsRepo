param(
    [string]$AdminWVD,
    [securestring]$AdminWVDPassword,
    [string]$WVDTenant
)

$CredentialWVD = New-Object System.Management.Automation.PSCredential($AdminWVD,$AdminWVDPassword)

Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -Credential $CredentialWVD

$AutomationName = "WEUDSTAUTZZZF00"
$AutomationAccount = Get-AzureADServicePrincipal | `
Where-Object DisplayName -Like $AutomationName | `
Select-Object -Property appId

New-RdsRoleAssignment -RoleDefinitionName "RDS Contributor" -ApplicationId $AutomationAccount.appId -TenantName "WEUDSTVDIZZZF99"
