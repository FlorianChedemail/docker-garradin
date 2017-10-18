<?php

/**
 * Ce fichier représente un exemple des constantes de configuration
 * disponibles pour Garradin.
 *
 * NE PAS MODIFIER CE FICHIER!
 *
 * Pour configurer Garradin, copiez ce fichier en 'config.local.php'
 * et modifiez ce dont vous avez besoin.
 */

// Nécessaire pour situer les constantes dans le bon namespace
namespace Garradin;

// Doit-on suggérer à l'utilisateur d'utiliser la version chiffrée du site ?
// 1 ou true = affiche un message de suggestion sur l'écran de connexion invitant à utiliser le site chiffré
// (conseillé si vous avez un certificat auto-signé ou peu connu type CACert)
// 2 = rediriger automatiquement sur la version chiffrée pour l'administration
// 3 = rediriger automatiquement sur la version chiffrée pour administration et site public
// false ou 0 = aucune version chiffrée disponible, donc ne rien proposer ni rediriger
define("PREFER_HTTPS", getenv('HTTPS_SECURITY_LEVEL'));

// Affichage des erreurs
// Si "true" alors un message expliquant l'erreur et comment rapporter le bug s'affiche
// en cas d'erreur. Sinon rien ne sera affiché.
// Défaut : true
define("SHOW_ERRORS", false);

// Hôte du serveur SMTP, mettre à false (défaut) pour utiliser la fonction
// mail() de PHP
define("SMTP_HOST", getenv('SMTP_HOST'));

// Port du serveur SMTP
// 25 = port standard pour connexion non chiffrée (465 pour Gmail)
// 587 = port standard pour connexion SSL
define("SMTP_PORT", getenv('SMTP_PORT'));

// Login utilisateur pour le server SMTP
// mettre à null pour utiliser un serveur local ou anonyme
define("SMTP_USER", getenv('SMTP_USER'));

// Mot de passe pour le serveur SMTP
// mettre à null pour utiliser un serveur local ou anonyme
define("SMTP_PASSWORD", getenv('SMTP_PASSWORD'));

// Sécurité du serveur SMTP
// NONE = pas de chiffrement
// SSL = connexion SSL (le plus sécurisé)
// STARTTLS = utilisation de STARTTLS (moyennement sécurisé)
define("SMTP_SECURITY", getenv('SMTP_SECURITY'));
