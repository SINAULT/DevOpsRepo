param(
    [string]$DomainADDS
)

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-domainName $DomainADDS `
-TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FADDS%2Ftemplate.json" `
-TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FADDS%2Fparameters.json"
