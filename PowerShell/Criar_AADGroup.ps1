$namegroup="" # Inserir o nome do grupo entre aspas
New-AzureADGroup -DisplayName "$namegroup" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"