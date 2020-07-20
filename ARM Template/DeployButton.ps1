$base="https://portal.azure.com/#create/Microsoft.Template/uri/"
$url="https://raw.githubusercontent.com/SINAULT/DevOpsRepo/master/ARM%20Template/Network/template.json"
$encodedUrl=[uri]::EscapeDataString($url)
"$base$encodedUrl"