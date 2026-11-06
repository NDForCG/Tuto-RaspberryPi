# Tutoriel Raspberry Pi n°1 : copier la clé publique sur le Pi depuis Windows (PowerShell).
# Remplace VOTRE_UTILISATEUR et l'adresse si besoin. ssh-copy-id n'existe pas sous Windows.
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh VOTRE_UTILISATEUR@rpi4.local "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
