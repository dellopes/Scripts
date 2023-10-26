#!/bin/bash
# Definicao de senha padrao para os logins da lista
echo -n "Digite a senha padrao:"
read -s senha
# Loop com os logins infomados no arquivo lista
for cont in $(cat "lista"); do
	sudo useradd -m $cont 
	sudo usermod -aG wheel $cont
	sudo usermod -aG docker $cont
	sudo usermod --shell /bin/zsh $cont
	echo $senha | sudo passwd --stdin $cont
        # Copiando aparencia e arquivos definidos no perfil padrao
	sudo cp -R /home/default/.zsh /home/$cont
        sudo cp -R /home/default/powerlevel10k /home/$cont
        sudo cp /home/default/.zshrc /home/$cont
        sudo cp /home/default/.bash_logout /home/$cont
        sudo cp /home/default/.bash_profile /home/$cont
        sudo cp /home/default/.bashrc /home/$cont
        sudo cp /home/default/.p10k.zsh /home/$cont
        # Modificando as permissoes com base no login da lista
        sudo chown -R $cont:$cont /home/$cont
done	
