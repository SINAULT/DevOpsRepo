Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
-TemplateFile "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Deletion/template.json" `
-Verbose -Mode Complete -Force