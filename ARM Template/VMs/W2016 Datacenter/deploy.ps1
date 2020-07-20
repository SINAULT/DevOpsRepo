Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEURSGDSTZZZF00 `
-Prefix "00" `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/VMs/W2016%20Datacenter/template.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/VMs/W2016%20Datacenter/parameters.json"