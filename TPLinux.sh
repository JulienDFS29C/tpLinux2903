#!/bin/bash

grantAccess(){

if [ $(id -u) -ne 0 ]; then
     echo "vous n'avez pas les droits nécessaires" && exit;
fi

}

grantAccess;


function createUser(){

adduser $2 && echo $3 | passwd $2 --stdin;
    echo "Utilisateur créé : $2"
    echo "Mot de passe enregistré"

}


function getNginx (){

     apt update && apt install nginx --assume-yes;
     apt install php mariaDB;
	

}

function siteConfig(){
	echo "$1";
	
		cp "/home/jux/Bureau/template" "/etc/nginx/sites-available/$2"
		echo "création du fichier $2";
	
	
	
	
	sed -i "s/{{http_port}}/$3/g" "/etc/nginx/sites-available/$2";
	sed -i "s/{{server_name}}/$2/g" "/etc/nginx/sites-available/$2";
	
	if [ -f "/var/www/$2" ]; then
			echo "répertoire $2 déjà créé"
	elif [ -f "/var/www/$2/index.hml" ]; then
			echo "fichier $2 déjà créé"
	else
			mkdir "/var/www/$2";
			cp "/home/jux/Bureau/indexTemplate.html"  "/var/www/$2/index.hml";
			echo "fichier $2 créé";
			sed -i "s/{{server_name}}/$2/g" "/var/www/$2/index.hml";
				
	fi;
	
}


function activateSite(){

ln -sv "/etc/nginx/sites-available/$2" "/etc/nginx/sites-enabled/$2";
systemctl restart nginx;

}


function diskCron() {

     bash /home/jux/Bureau/disk_monitor.sh;
	
}


function generate_ssh() {

    local ssh_key_path="/home/jux/.ssh/id_rsa_custom"

    
    ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N ""

    echo "Clé SSH créée dans $ssh_key_path"
}


case $1 in 

		user)
		createUser "$2" "$3"
		;;
		
		nginx)
		getNginx
		;;
		
		configure_site)
		siteConfig "$1" "$2" "$3"
		;;
		
		active_site)
		activateSite "$1" "$2"
		;;

		add_cronjob)
		diskCron "$1"
		;;
		
		generate_ssh)
        	generate_ssh
        	;;
		
esac;






		
		
