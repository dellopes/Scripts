Get-ADUser -Identity login01 -Properties memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members login02 -PassThru -ErrorAction SilentlyContinue |
Select-Object -Property samaccountname 