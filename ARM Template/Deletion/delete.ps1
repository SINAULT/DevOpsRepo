Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-TemplateFile "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FDeletion%2Ftemplate.json" `
-Verbose -Mode Complete -Force