#### Funcao criada para listar usuarios de forma simples, trazendo apenas as informacoes de login e diretorio shell
##### Adicionado na primeira linha do aqruivo ~/.zshrc


```
listusr() {
    cat /etc/passwd | awk -F: '$3 >= 1000 && $3 < 1999 {print "\033[0mUsuário: \033[34m" $1, "\033[0mShell: \033[34m" $NF}'
}

> listusr
Usuário: UsuarioA Shell: /usr/bin/zsh
Usuário: UsuarioB Shell: /bin/zsh
Usuário: UsuarioC Shell: /bin/zsh
Usuário: UsuarioD Shell: /bin/zsh
