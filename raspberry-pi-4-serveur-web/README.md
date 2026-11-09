# Tutoriel Raspberry Pi n°2 : un serveur web Nginx sur ton Raspberry Pi 4

Les fichiers et les commandes de la vidéo, à copier. Il te faut un Raspberry Pi accessible en SSH (voir le tutoriel n°1, `raspberry-pi-4-demarrage-headless`).

**Niveau de validation** : la page, le fichier de configuration, les commandes `nginx -t`, `ln -s`, `rm` et le rechargement ont été essayés avec Nginx 1.24 sous Ubuntu 24.04 (message d'erreur du point-virgule oublié compris). Le tutoriel **n'a pas été essayé sur un Raspberry Pi** (Raspberry Pi OS Lite, Nginx 1.22). Les adresses (192.168.1.27, 192.168.1.42), la date et les extraits de journal sont des exemples : chez toi, ils seront différents.

## 1. Installer Nginx (sur le Pi)

```bash
sudo apt update
sudo apt install nginx -y
systemctl status nginx
hostname -I
```

Ouvre `http://ADRESSE_DU_PI` dans un navigateur : la page **Welcome to nginx!** s'affiche.

## 2. Un dossier à nous, avec les bons droits

```bash
sudo mkdir -p /var/www/monsite
sudo chown -R $USER:$USER /var/www/monsite
ls -ld /var/www/monsite
```

Sans le `chown`, l'enregistrement dans nano échoue : `Error writing ... Permission denied` (le dossier appartient à `root`).

## 3. La page

```bash
nano /var/www/monsite/index.html
```

Contenu : [`index.html`](index.html) (enregistrer : Ctrl + O, Entrée ; quitter : Ctrl + X).

## 4. Dire à Nginx où trouver la page

```bash
sudo nano /etc/nginx/sites-available/monsite
```

Contenu : [`monsite`](monsite). **Chaque ligne se termine par `;`** : sinon, `nginx -t` répond `invalid number of arguments in "root" directive`.

```bash
sudo ln -s /etc/nginx/sites-available/monsite /etc/nginx/sites-enabled/
sudo nginx -t
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

`rm` ne supprime que le raccourci du site par défaut ; le fichier d'origine reste dans `sites-available`. Sans cette ligne, le site par défaut passe en premier et la page ne change pas.

## 5. Le téléphone et le journal

Sur le téléphone (même Wi-Fi que le Pi, pas les données mobiles) : `http://ADRESSE_DU_PI`.

```bash
sudo tail -n 2 /var/log/nginx/access.log
systemctl is-enabled nginx
```

Ce serveur n'est visible que depuis ton réseau local : ne l'ouvre pas sur internet sans le protéger.
