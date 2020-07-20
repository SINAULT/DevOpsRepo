param(
  [string]$WVDTenant,
  [string]$Subscription,
  [string]$AzureTenant
)

$resourceGroupName = "WEUDSTRSGZZZF00" # "Enter the name of the resource group for the new Azure Logic App"

$aadTenantId = $AzureTenant # "Enter your Azure AD tenant ID"

$subscriptionId = $Subscription # "Enter your Azure Subscription ID"

$tenantName = $WVDTenant # "Enter the name of your WVD tenant"

$hostPoolName = "WEUDSTWVDZZZF00" # "Enter the name of the host pool you'd like to scale"

$recurrenceInterval = "15" # "Enter how often you'd like the job to run in minutes, e.g. '15'"

$beginPeakTime = "9:00" # "Enter the start time for peak hours in local time, e.g. 9:00"

$endPeakTime = "15:00" # "Enter the end time for peak hours in local time, e.g. 18:00"

$timeDifference = "+2:00" # "Enter the time difference between local time and UTC in hours, e.g. +5:30"

$sessionThresholdPerCPU = "1" # "Enter the maximum number of sessions per CPU that will be used as a threshold to determine when new session host VMs need to be started during peak hours"

$minimumNumberOfRdsh = "0" # "Enter the minimum number of session host VMs to keep running during off-peak hours"

$limitSecondsToForceLogOffUser = "0" # "Enter the number of seconds to wait before automatically signing out users. If set to 0, users will be signed out immediately"

$logOffMessageTitle = "Logout Time" # "Enter the title of the message sent to the user before they are forced to sign out"

$logOffMessageBody = "This session will be your last of the day." # "Enter the body of the message sent to the user before they are forced to sign out"

$location = "westeurope" # "Enter the name of the Azure region where you will be creating the logic app"

$connectionAssetName = "AzureRunAsConnection" # "Enter the name of the Azure RunAs connection asset"

$webHookURI = "https://2078889b-32ae-47b3-b4bc-1dd286d3a3b0.webhook.we.azure-automation.net/webhooks?token=HH2nPx2SKqSifLOt47lBg%2bfcgFOXzg10OIoNCk%2fC%2b9U%3d" # "Enter the URI of the WebHook returned by when you created the Azure Automation Account"

$automationAccountName = "WEUDSTAUTZZZF00" # "Enter the name of the Azure Automation Account"

$maintenanceTagName = "NO-WVD" # "Enter the name of the Tag associated with VMs you don't want to be managed by this scaling tool"

.\createazurelogicapp.ps1 -ResourceGroupName $resourceGroupName `
  -AADTenantID $aadTenantId `
  -SubscriptionID $subscriptionId `
  -TenantName $tenantName `
  -HostPoolName $hostPoolName `
  -RecurrenceInterval $recurrenceInterval `
  -BeginPeakTime $beginPeakTime `
  -EndPeakTime $endPeakTime `
  -TimeDifference $timeDifference `
  -SessionThresholdPerCPU $sessionThresholdPerCPU `
  -MinimumNumberOfRDSH $minimumNumberOfRdsh `
  -LimitSecondsToForceLogOffUser $limitSecondsToForceLogOffUser `
  -LogOffMessageTitle $logOffMessageTitle `
  -LogOffMessageBody $logOffMessageBody `
  -Location $location `
  -ConnectionAssetName $connectionAssetName `
  -WebHookURI $webHookURI `
  -AutomationAccountName $automationAccountName `
  -MaintenanceTagName $maintenanceTagName