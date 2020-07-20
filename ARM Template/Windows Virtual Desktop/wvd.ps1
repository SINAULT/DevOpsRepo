#
#
#WARNING : This Powershell Script is obsolete. It has to be updated to the Spring 2020 Update!
#
#
#
Import-Module AzureAD

$User = Read-Host "Input UPN Azure Admin User"
$Password = Read-Host -AsSecureString "Input Password"
$Credential = New-Object System.Management.Automation.PSCredential($User,$Password)
$ADTenant = "f43e2fea-8e52-469a-a796-56e4c4bcb1f5"
$ADSubscription = "dcbde5ac-b981-45f9-b8b6-f77efa07ab2a"

Connect-AzAccount -Credential $Credential -Tenant $ADTenant

Select-AzSubscription -SubscriptionName "Lyon-IA-ouverte"

Write-Host = ""
$WVDAdminUser = Read-Host "Input WVD Admin User"
$WVDAdminUPN = Read-Host "Input UPN WVD Admin User"
$WVDAdminPassword = Read-Host -AsSecureString "Input Password"

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\UserManagement"

.\deployadmin.ps1 -UserAD $User `
-UserPassword $Password `
-AADTenant $ADTenant `
-Subscription $ADSubscription `
-AdminWVD $WVDAdminUser `
-AdminWVDPassword $WVDAdminPassword `
-AdminWVDUPN $WVDAdminUPN

Write-Host ""
Write-Host "###############################################"
Write-Host ""
Write-Host "The Windows Virtual Desktop Admin is configured"
Write-Host ""
Write-Host "###############################################"
Write-Host ""

.\deployusers.ps1 -UserAD $User -UserPassword $Password -AADTenant $ADTenant

Write-Host ""
Write-Host "###############################################"
Write-Host ""
Write-Host "The Windows Virtual Desktop User are configured"
Write-Host ""
Write-Host "###############################################"
Write-Host ""

New-AzResourceGroup -Name WEUDSTRSGZZZF00 -Location "westeurope"

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\NSG"

.\deploy.ps1

Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host "###### Network Security Group are created ######"
Write-Host ""
Write-Host "################################################"
Write-Host ""

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\VNET"

.\deploy.ps1

Write-Host ""
Write-Host "###############################################"
Write-Host ""
Write-Host "########## Virtual Network is created #########"
Write-Host ""
Write-Host "###############################################"
Write-Host ""

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\ADDS"

#$DomainName = Read-Host "Input AD Domain"

.\deploy.ps1 -DomainADDS $DomainName

Write-Host ""
Write-Host "########################################################"
Write-Host ""
Write-Host "###### Active Directory Domain Services is created #####"
Write-Host ""
Write-Host "########################################################"
Write-Host ""
Write-Host "Waiting for the ADDS to be in the status : Running..."
Write-Host ""
Pause
Write-Host ""

.\Select-GroupsToSync.ps1 -UserAD $User `
-UserPassword $Password `
-AADTenant $ADTenant `
-groupsToAdd @("AAD DC Administrators", "GS_WVD_Users")

Write-Host ""
Write-Host "The groups are starting to synchronize with the ADDS..."
Write-Host ""
Pause
Write-Host ""
Write-Host "You have to change the WVD Admin Password :"
Write-Host ""
$WVDAdminPassword = Read-Host -AsSecureString "Please enter the new Password"
Write-Host ""
.\WVDPasswordReset.ps1 -AdminWVDUPN $WVDAdminUPN -AdminWVDPassword $WVDAdminPassword
Write-Host ""
Write-Host "The Password has been changed. You may wait few minutes to synchronize with ADDS..."
Write-Host ""
Start-Sleep 300
Write-Host ""

###########################################################################################################################

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\VM"

.\deploy.ps1 -Domain $DomainName -AdminWVDUPN $WVDAdminUPN -AdminWVDPassword $WVDAdminPassword

Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host "######## AD Administration VM is created #######"
Write-Host ""
Write-Host "################################################"
Write-Host ""


Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\Storage"

#.\deploy.ps1
Write-Host "Create a Storage Account."
Write-Host ""
Write-Host "Configure AADDS Sync Option and a File Share."
Write-Host ""
Pause
Write-Host ""
Write-Host "###############################################"
Write-Host ""
Write-Host "########## Storage Account is created #########"
Write-Host ""
Write-Host "###############################################"
Write-Host ""

#Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\WVD"

$WVDTenantName = Read-Host "Input a WVD Tenant Name"

.\deploy.ps1 -AdminWVD $WVDAdminUPN `
-AdminWVDPassword $WVDAdminPassword `
-AzureTenant $ADTenant `
-Subscription $ADSubscription `
-Domain $DomainName `
-WVDTenant $WVDTenantName

Write-Host ""
Write-Host "###############################################"
Write-Host ""
Write-Host "###### Windows Virtual Desktop is created #####"
Write-Host ""
Write-Host "###############################################"
Write-Host ""


Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\Automation"
 
.\deploy1.ps1 -AdminWVD $WVDAdminUPN -AdminWVDPassword $WVDAdminPassword -Subscription $ADSubscription

Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host "########### AutomationAccount created ##########"
Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host "You need to activate the AutomationAccount before continue..."
Write-Host ""
Write-Host "Don't forget to copy the WebhookURL in the LogicApp File !!!"
Write-Host ""
Pause
###########################################################################################################################
.\deploy2.ps1 -AdminWVD $WVDAdminUPN -AdminWVDPassword $WVDAdminPassword -WVDTenant $WVDTenantName

Set-Location -Path "C:\Users\dylan.sinault\OneDrive - Magellan Partners\Template ARM\Windows Virtual Desktop\Logic App"

.\deploy.ps1 -WVDTenant $WVDTenantName -Subscription $ADSubscription -AzureTenant $ADTenant

Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host "############## Logic App is created ############"
Write-Host ""
Write-Host "################################################"
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "Congratulations everything is deployed successfully..."
Write-Host ""