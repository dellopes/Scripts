#Definir alteracao de senha no proximo logon
Import-Module ActiveDirectory

Import-Csv "C:\Scripts\usuarios.csv" | 
    ForEach-Object {
        $samAccountName = $_."samAccountName"

        Get-ADUser -Identity $samAccountName |

        Set-ADUser -ChangePasswordAtLogon:$True
    }