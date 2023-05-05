<#
    Script baseado na ação recomendada no Health Check VMware
--------------------------------------------------------------------------------------------------------
    1.	Use persistent and remote syslog logging to improve manageability
      
--------------------------------------------------------------------------------------------------------

#>


$vCenter = Read-Host 'Informe o vCenter Server'
$list = gc C:\Temp\Hosts.txt
$syslogserver = "" #Insira o hostname ou IP do servidor syslog remoto
connect-viserver $vCenter

Get-VMHost $list | Set-VMHostAdvancedConfiguration -NameValue @{'Syslog.global.defaultSize'='5120';'Syslog.global.defaultRotate'='40';'Syslog.global.logHost'='tcp://$syslogserver'}

#Habilitar porta no firewall
Get-VMHost $list | Get-VMHostFirewallException |?{$_.Name -eq 'syslog'} | Set-VMHostFirewallException -Enabled:$true

#Reiniciar Syslog service
$esxcli = Get-EsxCli -VMHost $list
$esxcli.system.syslog.reload()


disconnect-viserver $vCenter 