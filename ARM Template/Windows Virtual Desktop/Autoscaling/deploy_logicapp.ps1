[CmdletBinding()]
param (
    $User,
    $Password,
    $ADTenant,
    $SubscriptionId,
    $LogAnalyticsPrimaryKey
)
$UserPassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $UserPassword

Connect-AzAccount -Credential $Credential -Tenant $ADTenant

$Trigramme = "DST"

$AADTenantId = (Get-AzContext).Tenant.Id

$AzSubscription = (Get-AzContext).Subscription.Id

$ResourceGroup = Get-AzResourceGroup | where -FilterScript {$_.ResourceGroupName -match $Trigramme}

$WVDHostPool = Get-AzResource -ResourceType "Microsoft.DesktopVirtualization/hostpools" | where -FilterScript {$_.Name -match $Trigramme}

$AutoAccount = Get-AzAutomationAccount | where -FilterScript {$_.AutomationAccountName -match $Trigramme}

$LogAnalyticsWorkspace = Get-AzOperationalInsightsWorkspace | where -FilterScript {$_.Name -match $Trigramme}

$AutoAccountConnection = "AzureRunAsConnection"

$WebhookURIAutoVar = Get-AzAutomationVariable -Name 'WebhookURIARMBased' -ResourceGroupName $ResourceGroup.ResourceGroupName -AutomationAccountName $AutoAccount.AutomationAccountName

$LogAnalyticsWorkspaceId = $LogAnalyticsWorkspace.CustomerId # "If you want to use Log Analytics, enter the Log Analytics Workspace ID returned by when you created the Azure Automation account, otherwise leave it blank"
$LogAnalyticsKey = $LogAnalyticsPrimaryKey # "If you want to use Log Analytics, enter the Log Analytics Primary Key returned by when you created the Azure Automation account, otherwise leave it blank"
$RecurrenceInterval = "15" # "Enter how often you'd like the job to run in minutes, e.g. '15'"
$BeginPeakTime = "9:00" # "Enter the start time for peak hours in local time, e.g. 9:00"
$EndPeakTime = "17:00" # "Enter the end time for peak hours in local time, e.g. 18:00"
$TimeDifference = "+2:00" # "Enter the time difference between local time and UTC in hours, e.g. +5:30"
$SessionThresholdPerCPU = "1" # "Enter the maximum number of sessions per CPU that will be used as a threshold to determine when new session host VMs need to be started during peak hours"
$MinimumNumberOfRDSH = "1" # "Enter the minimum number of session host VMs to keep running during off-peak hours"
$MaintenanceTagName = "" # "Enter the name of the Tag associated with VMs you don't want to be managed by this scaling tool"
$LimitSecondsToForceLogOffUser = "0" # "Enter the number of seconds to wait before automatically signing out users. If set to 0, any session host VM that has user sessions, will be left untouched"
$LogOffMessageTitle = "" # "Enter the title of the message sent to the user before they are forced to sign out"
$LogOffMessageBody = "" # "Enter the body of the message sent to the user before they are forced to sign out"

$Params = @{
     "AADTenantId"                   = $AADTenantId                             # Optional. If not specified, it will use the current Azure context
     "SubscriptionID"                = $AzSubscription                       # Optional. If not specified, it will use the current Azure context
     "ResourceGroupName"             = $ResourceGroup.ResourceGroupName         # Optional. Default: "WVDAutoScaleResourceGroup"
     "Location"                      = $ResourceGroup.Location                  # Optional. Default: "West US2"
     "UseARMAPI"                     = $true
     "HostPoolName"                  = $WVDHostPool.Name
     "HostPoolResourceGroupName"     = $WVDHostPool.ResourceGroupName           # Optional. Default: same as ResourceGroupName param value
     "LogAnalyticsWorkspaceId"       = $LogAnalyticsWorkspaceId                 # Optional. If not specified, script will not log to the Log Analytics
     "LogAnalyticsPrimaryKey"        = $LogAnalyticsKey                  # Optional. If not specified, script will not log to the Log Analytics
     "ConnectionAssetName"           = $AutoAccountConnection              # Optional. Default: "AzureRunAsConnection"
     "RecurrenceInterval"            = $RecurrenceInterval                      # Optional. Default: 15
     "BeginPeakTime"                 = $BeginPeakTime                           # Optional. Default: "09:00"
     "EndPeakTime"                   = $EndPeakTime                             # Optional. Default: "17:00"
     "TimeDifference"                = $TimeDifference                          # Optional. Default: "-7:00"
     "SessionThresholdPerCPU"        = $SessionThresholdPerCPU                  # Optional. Default: 1
     "MinimumNumberOfRDSH"           = $MinimumNumberOfRDSH                     # Optional. Default: 1
     "MaintenanceTagName"            = $MaintenanceTagName                      # Optional.
     "LimitSecondsToForceLogOffUser" = $LimitSecondsToForceLogOffUser           # Optional. Default: 1
     "LogOffMessageTitle"            = $LogOffMessageTitle                      # Optional. Default: "Machine is about to shutdown."
     "LogOffMessageBody"             = $LogOffMessageBody                       # Optional. Default: "Your session will be logged off. Please save and close everything."
     "WebhookURI"                    = $WebhookURIAutoVar.Value
}

.\CreateOrUpdateAzLogicApp.ps1 @Params