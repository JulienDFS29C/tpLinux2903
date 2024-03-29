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


function getInstall (){

     apt update && apt install nginx php mariadb-client mariadb-server --assume-yes;
 
	

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
			echo "fichier $2 déjà créé"crontab -e
	else
			mkdir "/var/www/$2";
			cp "/home/jux/Bureau/indexTemplate.html"  "/var/www/$2/index.html";
			echo "fichier $2 créé";
			sed -i "s/{{server_name}}/$2/g" "/var/www/$2/index.html";
				
	fi;
	
}


function activateSite(){

ln -sv "/etc/nginx/sites-available/$2" "/etc/nginx/sites-enabled/$2";
systemctl restart nginx;

}


function diskCron() {


 	(crontab -l; echo "*/5 * * * * /home/jux/Bureau/disk_monitor.sh") | crontab -
    
    	echo "exécution de planifiée toutes les 5 minutes."
	
}


function generate_ssh() {

    local ssh_key_path="/home/jux/.ssh/id_rsa_custom"

    
    ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N ""

    echo "Clé SSH créée dans $ssh_key_path"
}

function phpSiteConfig(){

echo "$1";
	
		cp "/home/jux/Bureau/phpTemplate" "/etc/nginx/sites-available/$2"
		echo "création du fichier $2";
	
	
	
	
	sed -i "s/{{http_port}}/$3/g" "/etc/nginx/sites-available/$2";
	sed -i "s/{{server_name}}/$2/g" "/etc/nginx/sites-available/$2";
	
	if [ -f "/var/www/$2" ]; then
			echo "répertoire $2 déjà créé"
	elif [ -f "/var/www/$2/index.hml" ]; then
			echo "fichier $2 déjà créé"crontab -e
	else
			mkdir "/var/www/$2";
			cp "/home/jux/Bureau/phpTemplate.php"  "/var/www/$2/index.php";
			echo "fichier $2 créé";
			sed -i "s/{{server_name}}/$2/g" "/var/www/$2/index.hml";
				
	fi;


    ln -s "$site_path" /etc/nginx/sites-enabled/


    nginx -t && systemctl restart nginx
    echo "PHP site $1 configured on port $2."

}


case $1 in 

		user)
		createUser "$2" "$3"
		;;
		
		get_install)
		getInstall
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

		configure_php_site)
		phpSiteConfig "$1" "$2" "$3"
		;;
		


		
esac;






		
		
