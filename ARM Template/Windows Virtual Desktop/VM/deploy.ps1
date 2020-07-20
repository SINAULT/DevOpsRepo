param(
    [string]$Domain,
    [string]$AdminWVDUPN,
    [securestring]$AdminWVDPassword
)

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-Prefix "00" `
-domainToJoin $Domain `
-domainUsername $AdminWVDUPN `
-domainPassword $AdminWVDPassword `
-vmAdminPassword $AdminWVDPassword `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/VM/template.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/VM/parameters.json"