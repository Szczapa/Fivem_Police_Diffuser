# Bomb_Framework

Alpha 0.1

Projet pour serveur Role play, Système de bombe pour groupe illégaux.

Création de 6 types de bombe indépendante

- Bombe à télécommande
- Bombe à Timer
- Bombe démarrage moteur
- Bombe démarrage moteur + timer ( en cours de développement )
- Bombe Dépassement vitesse
- Bombe vitesse vérouillé ( interdiction de descendre sous une certaine vitesse)


Version 1.0 

Ajout du système LSPD avec intégration de système de désamorçage

- Scanner de véhicule
- Kit de désamorçage
- Intégration du mini jeu de code 
- Système d'alerte

Les bombe fonctionne désormais entre chaque redémarrage serveur avec une mise en sauvegarde sous forme de base de donnée Mysql et d'une table 


Roadmap Version 1.1
- Rework et optimisation du calcul de minuterie
- Changement du système de requête. L'objectif est de passer sur un fichier Json plus tot que de converser avec la base de donnée pour avoir des actualisations. 
