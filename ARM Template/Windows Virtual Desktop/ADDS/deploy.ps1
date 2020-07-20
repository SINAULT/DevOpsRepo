param(
    [string]$DomainADDS
)

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-domainName $DomainADDS `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/ADDS/template.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/ADDS/parameters.json"
