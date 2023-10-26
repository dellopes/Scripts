<#

Arquivo powershell do perfil do usuario.
Objetivo de ciar aliases para facilitar algumas atividades diarias

function dscripts => Abre o Visual Studio Code apontado para o diretorio de Scripts
function atividades => Abre o SublimeText e o Visual Studio Code com base no caminho \ 
onde sao criados diretoriose arquivos de controle de atividades, reunioes, comandos, \
anotacoes e links. 
Function MeuIP => Para descobrir meu IP publico de forma rapida
function recshell => funcao para recarregar o shell de perfil apos atualizacao sem a \
necessidade de fechar e reabrir o terminal.
function grep => Objetivo de simular o comando grep do linux (Em avaliacao)
function df => Objetivo de simular o comando df do linux


#>
function dscripts {
    param (
        [string]$Path = "C:\Users\LOGIN\Scripts"
    )

    & "code" $Path
}

function atividades {
    param (
        [string]$Path = "C:\Users\LOGIN\Atividades_diarias\2023"
    )

    & "subl" $Path
    & {dscripts}
    & wsl --distribution fedora --shell-type standard -- /bin/zsh -c /home/login/scripts/diretorios/atividades.sh

}

Function MeuIP {
 (Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function recshell {
        & $profile
}

function grep($regex, $dir) {
        if ( $dir ) {
                ls $dir | select-string $regex
                return
        }
        $input | select-string $regex
}

function df {
        get-volume
}

