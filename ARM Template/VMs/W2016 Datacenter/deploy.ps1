Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEURSGDSTZZZF00 `
-Prefix "00" `
-TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FVMs%2FW2016%20Datacenter%2Ftemplate.json" `
-TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FVMs%2FW2016%20Datacenter%2Fparameters.json"