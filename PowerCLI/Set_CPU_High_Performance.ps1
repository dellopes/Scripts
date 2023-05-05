<#
    Script baseado na ação recomendada no Health Check VMware
------------------------------------------------------------------------------------------------------------------
    2.	2.should consider to configure the current CPU power management. policy as High Performance 
        in all vSphere Hosts. Currently this option is configured as Balanced.
    Solução Aplicada:
    	Clicar no host > Configuration > Em Hardware > Overview > Em Power Management selecionar High Performance

------------------------------------------------------------------------------------------------------------------

#>

$vCenter = Read-Host 'Informe o vCenter Server'
$vmhost = gc C:\Temp\Hosts.txt

connect-viserver $vCenter


foreach ($HighPwrESXi in $vmhost){
    $view = (Get-VMHost $HighPwrESXi | Get-View)
        (Get-View $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)
            Write-Host "Power Management alterado para High Perfomance em $HighPwrESXi" -ForegroundColor green -BackgroundColor Black 

}