############################################################################
$Prefix = @()

$Prefix += "01"
$Prefix += "02"
$Prefix += "03"

foreach($count in $Prefix){
    New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
    -Prefix $count `
    -TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FNSG%2Ftemplate.json" `
    -TemplateParameterUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FNSG%2Fparameters.json"
}
############################################################################

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 -Prefix "01" `
-TemplateUri "https://dev.azure.com/dylansinault/_git/Personal%20Awesome%20Project?path=%2FARM%20Template%2FWindows%20Virtual%20Desktop%2FNSG%2FRDPrules.json"