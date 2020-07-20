param(
    [string]$AdminWVD,
    [securestring]$AdminWVDPassword,
    [string]$Subscription
)

$CredentialWVD = New-Object System.Management.Automation.PSCredential($AdminWVD,$AdminWVDPassword)

Login-AzAccount -Credential $CredentialWVD

.\createazureautomationaccount.ps1 -SubscriptionID $Subscription -ResourceGroupName "WEUDSTRSGZZZF00"  -AutomationAccountName "WEUDSTAUTZZZF00" -Location "westeurope"
