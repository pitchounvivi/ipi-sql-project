# ipi-sql-project
evaluated project


===================================================================

# Sujet du projet

Voir fichier .txt fourni

## Récapitulatif

Le but du projet est de créer la base de données PostgreSQL ou SQLite d’une
application web. Le sujet est libre, même si des contraintes sont fixées.


Il faut impérativement un seul fichier SQL, avec des commentaires, comprenant :

- un schéma de base de données avec au moins 8 tables, toutes jointes, avec
  entre autres :
  - au moins une relation n-n (donc une table de jointure),
  - des contraintes, dont des index utiles.

- un jeu des données avec (un peu) de contenu cohérent pour toutes les tables,

- des requêtes réalistes présentant des cas concrets, dont :
  - au moins une avec LIKE,
  - au moins une avec GROUP BY et une fonction d’agrégat,
  - au moins une avec HAVING,
  - au moins une avec JOIN,
  - au moins une avec OUTER JOIN.


Je ne regarde pas :

- le style (il faut quand même que ce soit lisible…),
- la quantité de colonnes et de contenu.


Je regarde :

- le fait que le script s’exécute tel quel sans erreur,
- la qualité et la normalisation du modèle de données,
- le réalisme du jeu de données et le fait qu’il s’articule bien avec les
  requêtes,
- la complexité (seulement quand elle est nécessaire),
- la performance des requêtes (pas la peine d’optimiser à fond, juste éviter
  les pièges les plus évidents).

===================================================================

# Corrections et commentaires originaux du professeur disponible sur :


https://github.com/pitchounvivi/ipi-python-project/pull/3

===================================================================

SQL

C’est un excellent travail, bravo.

Le sujet est très bien respecté. Les commentaires sont très pertinents, et ils donnent le sourire :). Il y a une vraie attention portée à la cohérence dans les noms de tables et de colonnes, c’est un travail soigné (j’apprécie beaucoup).

Le modèle est cohérent. Votre remarque sur le lien entre les livres et les auteurs est intéressante… Ce problème assez classique peut être résolu de multiples manières, qui dépendent de la manière dont va évoluer la base. Si votre liste de métiers évolue très rarement (ce qui serait plutôt le cas ici), la solution actuelle est acceptable et simplifie grandement le schéma. Par contre, dans les cas où cette liste est amenée à évoluer, il vaut en effet mieux mettre l’information dans la table de jointure, voire à l’extrême faire une ternaire comme vous le proposez.

Les index sont simples mais judicieux (c’est beaucoup mieux que « complexes et pas judicieux »).

Le jeu de données est conséquent, on a de quoi s’amuser avec vos requêtes qui sont très claires. C’est presque frustrant, j’aurais aimé avoir quelques requêtes un peu plus complexes, surtout entre les personnages, les équipes et les livres ! Cela dit, vous avez bien suivi les recommandations du sujet, je ne peux pas vous en vouloir :).

Quelques remarques :

    Vous pouvez insérer les données d’une table avec une seule commande INSERT.
    Les booléens doivent être indiqués comme 0 et 1. La gestion des types en SQLite est vraiment très particulière, c’est pour cela qu’il accepte 'oui' et 'non' qui sont en réalité tous les deux vus comme 0/faux.
    La catégorie de capacité pourrait être un booléen, ou avoir une contrainte sur une liste fixe de valeurs, ou être une jointure.
    Utiliser AUTOINCREMENT pour les clés primaires avec SQLite n’est pas recommandé. La première phrase de la documentation officielle est même "The AUTOINCREMENT keyword imposes extra CPU, memory, disk space, and disk I/O overhead and should be avoided if not strictly needed. It is usually not needed." ;).

