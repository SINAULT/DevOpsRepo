Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Network/VNET/azuredeploy.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Network/VNET/azuredeploy.parameters.json"
