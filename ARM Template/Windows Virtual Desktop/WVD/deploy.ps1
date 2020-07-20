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
    -TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/WVD/template.json" `
    -TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/WVD/parameters.json"

