# Importa o Modulo Active Directory para o Shell
Import-Module activedirectory
#Declaracao de Variaveis
# Data
$data=get-date -UFormat %d-%m-%y_%H-%M
#Contagem de Contas Ativas
$conta = (Get-ADUser -filter {(Enabled -eq $true)}).count         
#Exibicao interativa da execucao da atividade
write-host "`n"
write-host "`n"
Write-Host ######################
Write-Host REALIZANDO CONTAGEM... -ForegroundColor Green
Write-Host ######################
write-host "`n"
#Limpeza da Tela
Clear-Host
#Exibicao interativa da execucao da atividade
Write-Host #####################
Write-Host CONTAGEM FINALIZADA!! -ForegroundColor Green
Write-Host #####################
Write-Host ####################################
Write-Host SALVANDO ARQUIVO DE CONTAS ATIVAS... -ForegroundColor Green
Write-Host ####################################
# Sintaxe de consulta de contas ativas no AD, com os atributos solicitados pela Auditoria e exportacao das informacoes para um arquivo .CSV
Get-ADUser -filter {(Enabled -eq $true)} –Properties "Name", "samaccountname", "Description",  "Mail", "ObjectClass", 
"tipoconta", "distinguishedName", "CannotChangePassword", "PasswordLastSet", "PasswordNotRequired", "PasswordNeverExpires", "PasswordExpired", 
    “msDS-UserPasswordExpiryTimeComputed”, "UserPrincipalName", "Enabled", "LockedOut", "AccountExpirationDate", "LastLogonDate" , "whenCreated" |
        Select-Object -Property "name", "samaccountname", "Description",  "Mail", "ObjectClass", "tipoconta", "distinguishedName", 
            "CannotChangePassword", "PasswordLastSet", "PasswordNotRequired", "PasswordNeverExpires", "PasswordExpired",
                @{Name=“PswdExpiresTime”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}, "UserPrincipalName", "Enabled", 
                    "LockedOut", "AccountExpirationDate", "LastLogonDate" , "whenCreated" | 
                        Sort-Object -Property name |
                            Export-Csv \\fileserver\Auditoria_AD\Relatorios_Auditoria\Relatorio_Ativos_Auditoria_$data.csv -Encoding UTF8 -NoTypeInformation
# Sintaxe de adicao de rotulo para saida da variavel de consulta e contagem de contas para adicionar o resultado no final do arquivo .CSV
'Total de Contas'+' '+'='+' '+$conta >> \\fileserver\Auditoria_AD\Relatorios_Auditoria\Relatorio_Ativos_Auditoria_$data.csv
#Exibicao interativa da execucao da atividade
Write-Host ###########################
Write-Host ARQUIVO SALVO COM SUCESSO!! -ForegroundColor Green 
Write-Host ###########################
Start-Sleep -Seconds 5
Clear-Host
write-host "`n"
write-host "`n"
Write-Host ######################
Write-Host TOTAL DE CONTAS ATIVAS = $conta -ForegroundColor Yellow -BackgroundColor Black
Write-Host ######################
write-host "DATA:" $data -foreground Cyan -BackgroundColor Black
Write-Host ################
Write-Host NOME DA EMPRESA -ForegroundColor Red -BackgroundColor White
Write-Host ################
write-host "`n"