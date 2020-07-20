Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-Prefix "00" `
-TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FVMs%2FUbuntu%2018.04%20LTS%2FCustomScript%2Ftemplate-script.json" `
-TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FVMs%2FUbuntu%2018.04%20LTS%2FCustomScript%2Fparameters.json"