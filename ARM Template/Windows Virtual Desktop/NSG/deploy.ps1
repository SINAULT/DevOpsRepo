############################################################################
$Prefix = @()

$Prefix += "01"
$Prefix += "02"
$Prefix += "03"

foreach($count in $Prefix){
    New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 `
    -Prefix $count `
    -TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/NSG/template.json" `
    -TemplateParameterUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/NSG/parameters.json"
}
############################################################################

New-AzResourceGroupDeployment -ResourceGroupName WEUDSTRSGZZZF00 -Prefix "01" `
-TemplateUri "https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Windows%20Virtual%20Desktop/NSG/RDPrules.json"