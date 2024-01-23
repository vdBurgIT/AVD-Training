#Description: This script will delete all resource groups in all subscriptions in the account.
#requirement: You must have the Az.Resources and Az.Accounts modules installed. You can install them with the following commands:
#Install-Module -Name Az.Resources
#Install-Module -Name Az.Accounts
#You must also be logged in to the account you want to delete the resource groups from. You can log in with the following command:
#Connect-AzAccount
#You can also use the following command to log in to a specific subscription:
#Connect-AzAccount -SubscriptionId <subscriptionId>



#Import modules

Import-Module Az.Resources
import-module Az.Accounts

# Login to Azure Account
Connect-AzAccount

# Get all subscriptions in the account
$subscriptions = Get-AzSubscription

foreach ($subscription in $subscriptions) {
    # Select the subscription
    Set-AzContext -SubscriptionId $subscription.Id

    # Get all resource groups in the current subscription
    $resourceGroups = Get-AzResourceGroup

    foreach ($resourceGroup in $resourceGroups) {
        # Delete the resource group
        Remove-AzResourceGroup -Name $resourceGroup.ResourceGroupName -Force -AsJob
    }
}

# Wait for all jobs to complete
Get-Job | Wait-Job

# Output completion message
Write-Host "All resource groups in all subscriptions have been deleted."
