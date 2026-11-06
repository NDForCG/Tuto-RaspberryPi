# Tutoriel Raspberry Pi n°1 : démarrer un Raspberry Pi 4 sans écran, SSH et clé SSH

Les commandes de la vidéo, à copier.

**Niveau de validation** : la syntaxe de la configuration `sshd` et la génération de clé `ed25519` ont été vérifiées sur un Linux (Ubuntu). Le reste (Imager, démarrage du Pi, Wi-Fi, résolution de `rpi4.local`) n'a **pas été essayé sur un Raspberry Pi**. Les valeurs affichées dans la vidéo (adresse IP, mémoire, température) sont des exemples.

## 1. Écrire la carte

Raspberry Pi Imager, Raspberry Pi 4, **Raspberry Pi OS Lite (64-bit)**. Personnalisation : nom d'hôte `rpi4`, utilisateur et mot de passe, Wi-Fi **avec le pays**, SSH activé.

## 2. Trouver le Pi et se connecter

```bash
ping rpi4.local
ssh VOTRE_UTILISATEUR@rpi4.local
```

Si `rpi4.local` ne répond pas, lire l'adresse du Pi dans la liste des appareils de la box, puis :

```bash
ping ADRESSE_IP
ssh VOTRE_UTILISATEUR@ADRESSE_IP
```

## 3. Mettre à jour et regarder la machine (sur le Pi)

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

Après le redémarrage, reconnecte-toi puis :

```bash
cat /proc/device-tree/model
free -h
df -h
vcgencmd measure_temp
hostname -I
```

## 4. La clé SSH (sur ton ordinateur, pas sur le Pi)

```bash
ssh-keygen -t ed25519 -C "mon-pc"
ssh-copy-id VOTRE_UTILISATEUR@rpi4.local
```

Sous Windows, `ssh-copy-id` n'existe pas : utilise [`cle-ssh-windows.ps1`](cle-ssh-windows.ps1). Vérifie ensuite que `ssh VOTRE_UTILISATEUR@rpi4.local` ne demande plus le mot de passe du Pi.

## 5. Interdire le mot de passe (facultatif, sur le Pi)

**Seulement après avoir testé la clé, et en gardant une session ouverte** (sinon tu t'enfermes dehors et il faut réécrire la carte). Le script [`durcir-ssh.sh`](durcir-ssh.sh) écrit le fichier [`10-durcissement.conf`](10-durcissement.conf) et vérifie la configuration. Une fois les deux lignes `no` affichées :

```bash
sudo systemctl reload ssh
```

Ouvre ensuite une **deuxième** session pour vérifier que la clé marche toujours.

## 6. Éteindre proprement

```bash
sudo shutdown -h now
```

Attends que la LED verte cesse de clignoter avant de débrancher.
