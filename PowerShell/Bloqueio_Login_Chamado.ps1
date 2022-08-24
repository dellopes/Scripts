#Versao 4.0
 
#Declaracao de Variavel de data
$data=get-date -UFormat %d-%m-%y_%H-%M
$CHAMADO="CodigoDoChamado"
# Gravacao do shell de execucao
Start-Transcript -Path "\\fileserver\Auditoria_AD\Bloqueio_Logins\Logs\Bloqueio_$data.txt" -NoClobber
#Importacao do Modulo Active Directory
Import-Module ActiveDirectory
#Criacao do arquivo de logins para bloqueio
New-Item -Path "\\fileserver\Auditoria_AD\Desligamentos\Bloqueio_SIAM_$CHAMADO.csv" -ItemType File
    Set-Content -Path "\\fileserver\Auditoria_AD\Desligamentos\Bloqueio_SIAM_$CHAMADO.csv" -Value 'SamAccountname
login001
login002
login003
login004'
#Comando para importar a lista de usuarios a serem bloqueados Gente Gestao
 Import-Csv "\\fileserver\Auditoria_AD\Desligamentos\Bloqueio_SIAM_$CHAMADO.csv" | ForEach-Object {
    $SamAccountName = $_."SamAccountName"
        Get-ADUser -Identity $SamAccountName | Disable-ADAccount
        Set-ADUser -Identity $SamAccountName -Replace @{"chamadosiamD"="$CHAMADO"}
#Exclusao de todos os Grupos do usuario
        Get-ADUser -Identity $SamAccountName -Properties memberof |
            Select-Object -ExpandProperty memberof |
                Remove-ADGroupMember -Members $SamAccountName -ErrorAction Continue -confirm:$false
#Mover os usuarios para OU Userdisable
                    Get-ADUser $SamAccountName | Move-ADObject -TargetPath "OU=UserDisable,DC=regiao,DC=empresa,DC=com,DC=br"
}
#Exibicao interativa da execucao da atividade
write-host "`n"
write-host "`n"
    Write-Host ######################
    Write-Host Bloqueio realizado com Sucesso!! -ForegroundColor Green
    Write-Host ######################
write-host "`n"
Start-Sleep -Seconds 3
#Limpeza da Tela
Clear-Host
#Exibicao interativa da execucao da atividade
write-host "`n"
write-host "`n"
    Write-Host ######################
    Write-Host Realizando Consulta... -ForegroundColor Green
    Write-Host ######################
write-host "`n"
Start-Sleep -Seconds 3
Clear-Host
Import-Csv "\\fileserver\Auditoria_AD\Desligamentos\Bloqueio_SIAM_$CHAMADO.csv" | ForEach-Object {
    $SamAccountName = $_."SamAccountName"
        Get-ADUser -Identity $SamAccountName -Properties * |Select-Object -Property name, samaccountname, enabled, employeetype, chamadosiamD
            } |Format-Table
Stop-Transcript