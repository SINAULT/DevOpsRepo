Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FNetwork%2FVNET%2Ftemplate.json" `
-TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FNetwork%2FVNET%2Fparameters.json"
