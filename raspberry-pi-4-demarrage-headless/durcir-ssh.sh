#!/bin/bash
# Tutoriel Raspberry Pi n°1 : interdire le mot de passe en SSH (à lancer SUR le Raspberry Pi).
# ATTENTION : garde ta première session SSH ouverte, et vérifie la connexion par clé dans une 2e session avant de fermer la première.
set -e
sudo tee /etc/ssh/sshd_config.d/10-durcissement.conf > /dev/null <<'CONF'
PasswordAuthentication no
PermitRootLogin no
CONF
sudo sshd -t                                             # ne doit rien afficher
sudo sshd -T | grep -Ei '^(passwordauthentication|permitrootlogin)'   # doit afficher "no" deux fois
echo "Si les deux lignes ci-dessus disent 'no' : sudo systemctl reload ssh"
