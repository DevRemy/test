#!/bin/bash

echo Inialisation pour l\'agent GLPI

isRoot=$(whoami)

if [ "$isRoot" != "root" ]; then
	echo "Vous devez lancer le terminal en mode administrateur"
	exit
fi

echo Mise a jour du systéme

apt-get clean

apt-get update
apt-get upgrade -y

echo "Nettoyage du systéme"

apt-get autoclean
apt-get autoremove -y



echo -en " Renomage du poste, entré le numero d'inventaire : "
read  newName

hostnamectl set-hostname $newName
hostnamectl

echo Installation de l\'agent GLPI

echo -en "Entrée votre identifiant TSE :"
	read tse


perl glpi-agent.pl -s "http://192.168.0.37/front/inventory.php" -t $tse

echo "Installation de l\'agent GLPI est fini, lancement de l'inventaire"

glpi-agent

echo "L'inventaire a était réalisée"

exit;
