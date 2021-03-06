# Powershell Script to Get Mailbox Stats from Specific Exchange Server
# Tom Seery 8/4/2014

#Add Exchange Management Shell Snapin - The MS Exchange Tools must be installed on the computer running the script
if ((Get-PSSnapin -Name 'Microsoft.Exchange.Management.PowerShell.Admin' -ErrorAction SilentlyContinue) -eq $null)
{
    Add-PSSnapin -name:'Microsoft.Exchange.Management.PowerShell.Admin'
}  

#Get Mailbox Statistics for Hong Kong Mail Server and export to file.  Server and file path/name can be customized.

#File to save report formatted with date and time
$filename = "c:\NYMailboxes{0:yyyyMMdd-HHmm}.csv" -f (Get-Date)

#Get Mailbox Statistics for New York Mail Server and export to file.  Server name can be customized.
Get-Mailboxstatistics -database "<servername and database path" | where-object {$_.TotalItemSize -ge 0} |
 Select-object -property @{label='User';Expression={$_.DisplayName}}, @{label='Mailbox Size (MB)';Expression={$_.TotalItemSize.Value.ToMB()}}, StorageLimitStatus |
 Sort-Object 'Mailbox Size (MB)' -descending | Out-File -FilePath $filename