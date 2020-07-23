Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 -TemplateFile "./template.json" -TemplateParameterFile "./parameters.json"