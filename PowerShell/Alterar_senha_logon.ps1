#Definir alteracao de senha no proximo logon de logins com base no arquivo usuarios.csv
Import-Module ActiveDirectory

Import-Csv "C:\Scripts\usuarios.csv" | 
    ForEach-Object {
        $samAccountName = $_."samAccountName"

        Get-ADUser -Identity $samAccountName |

        Set-ADUser -ChangePasswordAtLogon:$True
    }