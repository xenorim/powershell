# SCCM Montly Patching Script


function Get-PatchTuesday {
<#  
  .SYNOPSIS   
    Get the Patch Tuesday of a month 
  .PARAMETER month 
   The month to check
  .PARAMETER year 
   The year to check
  .EXAMPLE  
   Get-PatchTue -month 6 -year 2015
  .EXAMPLE  
   Get-PatchTue June 2015
#> 
 
param( 
[string]$month = (get-date).month, 
[string]$year = (get-date).year
) 

$firstdayofmonth = [datetime] ([string]$month + "/1/" + [string]$year)
(0..30 | % {$firstdayofmonth.adddays($_) } | ? {$_.dayofweek -like "Tue*"})[1]
 
}

# Variables
$sccmmonth = Get-Date -uformat %m
$sccmyear = (Get-Date).Year
$servergroup = Get-CMSoftwareUpdateGroup -name "Enterprise - All Server Patches Monthly - $sccmyear-$sccmmonth *"  #Grabs patch group for the current month
$workstationgroup = Get-CMSoftwareUpdateGroup -name "Enterprise - All Workstation Patches Monthly - $sccmyear-$sccmmonth *"