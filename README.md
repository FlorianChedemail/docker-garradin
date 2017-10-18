# docker-garradin
Version dockerisée de Garradin 
http://garradin.eu/

## Installation
1. Cloner le repo
2. Build l'image `docker build -t [tag de l'image] .`  
Exemple : `docker build -t fchedemail/garradin .`
3. Run le container `docker run -d --env [variables d'environnement] [tag de l'image]`  
Exemple : `docker run -d --env SECURITY_LEVEL=1 --env SMTP_PORT=25  fchedemail/garradin`

## Options d'environnement
```
// Doit-on suggérer à l'utilisateur d'utiliser la version chiffrée du site ?
// 1 ou true = affiche un message de suggestion sur l'écran de connexion invitant à utiliser le site chiffré
// (conseillé si vous avez un certificat auto-signé ou peu connu type CACert)
// 2 = rediriger automatiquement sur la version chiffrée pour l'administration
// 3 = rediriger automatiquement sur la version chiffrée pour administration et site public
// false ou 0 = aucune version chiffrée disponible, donc ne rien proposer ni rediriger
HTTPS_SECURITY_LEVEL

// Hôte du serveur SMTP, mettre à false (défaut) pour utiliser la fonction
// mail() de PHP
SMTP_HOST

// Port du serveur SMTP
// 25 = port standard pour connexion non chiffrée (465 pour Gmail)
// 587 = port standard pour connexion SSL
SMTP_PORT

// Login utilisateur pour le server SMTP
// mettre à null pour utiliser un serveur local ou anonyme
SMTP_USER

// Mot de passe pour le serveur SMTP
// mettre à null pour utiliser un serveur local ou anonyme
SMTP_PASSWORD

// Sécurité du serveur SMTP
// NONE = pas de chiffrement
// SSL = connexion SSL (le plus sécurisé)
// STARTTLS = utilisation de STARTTLS (moyennement sécurisé)
SMTP_SECURITY
```
