Connect-AzureAD -credential login # utilizar samaccountname Ex. joao.maria
Get-AzureADUserRegisteredDevice  -ObjectId "login@dominio" # utilizar a informacao do atributo userprincipalname (UPN) Ex. joao.maria@contoso.com
Get-AzureADUserRegisteredDevice -DeviceId "hostname" # utilizar o nome da estacao de trabalho
Get-AzureADUserOwnedDevice -ObjectId "login@dominio" # utilizar a informacao do atributo userprincipalname (UPN) Ex. joao.maria@contoso.com