##################################################################
### Open connections to UCSM instances based on pre-saved file ###
### Documentation available at:                                ###
### https://www.cisco.com/c/en/us/td/docs/unified_computing/ucs/sw/msft_tools/powertools/ucs_powertool_book/2x/b_Cisco_UCSM_PowerTool_UG_Release_2x/b_Cisco_UCSM_PowerTool_UG_Release_2x_chapter_01.html#id_16015
##################################################################
Write-Output ""
Write-Host -ForegroundColor Cyan "Connecting to UCSM instances..."
Connect-Ucs -LiteralPath C:\Users\USERNAME\Documents\WindowsPowerShell\Scripts\Credentials.xml | Select-Object Name, Ucs | Sort-Object Name | Format-Table -AutoSize
Write-Output ""
Write-Output ""
######################################################
### Build UCSM cluster name translation dictionary ###
######################################################
$UcsDomains = @{}
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')
$UcsDomains.add('xxxxx', 'xxxxx')

#####################################
### List WWN pools per UCS domain ###
#####################################
Write-Host -ForegroundColor Cyan "Exporting WWN pools per UCS domain..."
Get-UcsWwnMemberBlock | Select @{Name="UcsDomain";Expression={$UcsDomains[$_."Ucs"]}}, @{Name="FIClusterName";Expression={$_."Ucs"}}, From, To, @{Name="Pool";Expression={$_."Dn" -replace "org-root/wwn-pool-","" -replace "/block(.*)",""}} | Sort-Object UcsDomain, Pool | Export-CSV -NoTypeInformation .\WWNPools.csv
Write-Output ""
Write-Output ""
#####################################
### List MAC pools per UCS domain ###
#####################################
Write-Host -ForegroundColor Cyan "Exporting MAC pools per UCS domain..."
Get-UcsMacMemberBlock | Select @{Name="UcsDomain";Expression={$UcsDomains[$_."Ucs"]}}, @{Name="FIClusterName";Expression={$_."Ucs"}}, From, To, @{Name="Pool";Expression={$_."Dn" -replace "org-root/mac-pool-","" -replace "/block(.*)",""}} | Sort-Object UcsDomain, Pool | Export-CSV -NoTypeInformation .\MACPools.csv
Write-Output ""
Write-Output ""
Write-Host -ForegroundColor Cyan "Disconnecting from UCSM instances..."
Disconnect-Ucs | Select-Object @{Name="UcsDomain";Expression={$_."Name"}}, @{Name="FIClusterName";Expression={$_."Ucs"}}, OutStatus | Sort-Object UcsDomain | Format-Table -AutoSize