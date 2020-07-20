param(
    [string]$AdminWVD,
    [securestring]$AdminWVDPassword,
    [string]$AzureTenant,
    [string]$Subscription,
    [string]$Domain,
    [string]$WVDTenant
)

$CredentialWVD = New-Object System.Management.Automation.PSCredential($AdminWVD,$AdminWVDPassword)

Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -Credential $CredentialWVD

#Add Windows Virtual Desktop Tenant

New-RdsTenant -Name $WVDTenant -AadTenantId $AzureTenant -AzureSubscriptionId $Subscription

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
    -existingDomainUPN $AdminWVD `
    -existingDomainPassword $AdminWVDPassword `
    -domainToJoin $Domain `
    -existingTenantName $WVDTenant `
    -tenantAdminUpnOrApplicationId $AdminWVD `
    -tenantAdminPassword $AdminWVDPassword `
    -TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FWVD%2Ftemplate.json" `
    -TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FWVD%2Fparameters.json"

