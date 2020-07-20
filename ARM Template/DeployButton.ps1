$base="https://portal.azure.com/#create/Microsoft.Template/uri/"
$url=""
$encodedUrl=[uri]::EscapeDataString($url)
"$base$encodedUrl"