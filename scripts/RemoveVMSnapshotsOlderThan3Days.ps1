#The GitHub VM creates a daily snapshot.  This script deletes snapshots older than three days.
#Tom Seery 6-31-2013

#Check to see if VMWare Snapin has been added
if(!(Get-PSSnapin VMWare.Vimautomation.Core -ErrorAction SilentlyContinue)){
    Add-PSSnapin VMWare.Vimautomation.Core
} 

#Connect to VCenter Server
Connect-VIServer <Vcenter name>

#Remove Snapshots older than 3 days
Get-VM 'GITHUB - GitHubEnterprise' | Get-Snapshot | Where { $_.Created -lt (Get-Date).AddDays(-3)} | remove-snapshot -Confirm:$false