Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/VMs/Ubuntu%2018.04%20LTS/azuredeploy.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/VMs/Ubuntu%2018.04%20LTS/azuredeploy.parameters.json"