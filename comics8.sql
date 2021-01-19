-- Fait pour une base SQLITE --


PRAGMA foreign_keys = off;
BEGIN TRANSACTION;


----------------------------
-- Remarque conception : le schema de la base de donnée actuel n'est pas très bon.
-- En effet, il faut ajouter une table intermédiaire role entre livre et auteur, mais également ajouter une table métier. L'ensemble formerait une relation ternaire livre, auteur(deviendrait personne) et métier se rejoindraient dans la table intermédiaire role.
-- 
-- Toutefois comme vous n'en vouliez pas trop, on s'arrête à ce schéma là.
----------------------------
-- Petite précision pour la table livre : livre_reference_editeur correspond à un numéro ISBN
----------------------------




-------------------------
-- Creation des tables
-------------------------
-----------------
-- Table : auteur 
DROP TABLE IF EXISTS auteur;

CREATE TABLE auteur (
    auteur_id     INTEGER      PRIMARY KEY AUTOINCREMENT,
    auteur_nom    VARCHAR (50),
    auteur_prenom VARCHAR (50) 
);

-------------------
-- Table : capacite
DROP TABLE IF EXISTS capacite;

CREATE TABLE capacite (
    capacite_id        INTEGER       PRIMARY KEY AUTOINCREMENT,
    capacite_nom       VARCHAR (100),
    capacite_categorie VARCHAR (50) 
);
-- Index : lors de leur recherche les utilisateurs vont rechercher les noms des capacités
CREATE INDEX index_capacite_nom
ON capacite (capacite_nom);

---------------------
-- Table : couverture
DROP TABLE IF EXISTS couverture;

CREATE TABLE couverture (
    couverture_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    couverture_image       BLOB    NOT NULL,
    couverture_dessinateur INTEGER REFERENCES  livre (livre_dessinateur),
    couverture_encreur     INTEGER REFERENCES  livre (livre_encreur),
    couverture_date        DATE,
    livre_id               INTEGER REFERENCES  livre (livre_id) 
);

------------------
-- Table : editeur
DROP TABLE IF EXISTS editeur;

CREATE TABLE editeur (
    editeur_id  INTEGER      PRIMARY KEY AUTOINCREMENT,
    editeur_nom VARCHAR (50) 
);

-------------------------
-- Table : edition_auteur
DROP TABLE IF EXISTS edition_auteur;

CREATE TABLE edition_auteur (
    edition_id INTEGER REFERENCES editeur (editeur_id),
    auteur_id  INTEGER REFERENCES auteur (auteur_id) 
);

-----------------
-- Table : equipe
DROP TABLE IF EXISTS equipe;

CREATE TABLE equipe (
    equipe_id         INTEGER       PRIMARY KEY AUTOINCREMENT,
    equipe_nom        VARCHAR (100),
    equipe_statut     VARCHAR (50),
    equipe_temporaire BOOLEAN
);

----------------
-- Table : livre
DROP TABLE IF EXISTS livre;

CREATE TABLE livre (
    livre_id                INTEGER       PRIMARY KEY AUTOINCREMENT,
    livre_titre             VARCHAR (200) NOT NULL,
    livre_contenu           TEXT,
    livre_scenariste        INTEGER       REFERENCES auteur (auteur_id),
    livre_dessinateur       INTEGER       REFERENCES auteur (auteur_id),
    livre_encreur           INTEGER       REFERENCES auteur (auteur_id),
    livre_reference_editeur INTEGER       UNIQUE,
    livre_date              DATE            
);
-- Index : les utilisateurs recherchent souvent un livre avec son nom (ou une partie de celui-ci) ou sa date de parution (pour les geek et il y en a)
CREATE INDEX index_livre_titre
ON livre (livre_titre);
CREATE INDEX index_livre_date
ON livre (livre_date);

------------------------
-- Table : livre_editeur
DROP TABLE IF EXISTS livre_editeur;

CREATE TABLE livre_editeur (
    livre_id   INTEGER REFERENCES livre (livre_id),
    editeur_id INTEGER REFERENCES editeur (editeur_id) 
);

---------------------
-- Table : personnage
DROP TABLE IF EXISTS personnage;

CREATE TABLE personnage (
    perso_id     INTEGER      PRIMARY KEY AUTOINCREMENT,
    perso_nom    VARCHAR (50),
    perso_prenom VARCHAR (50),
    perso_alias  VARCHAR (50) NOT NULL
);
-- Index : typiquement les gens recherchent beaucoup les supers héros et autre par leur alias
CREATE INDEX index_alias
ON personnage (perso_alias);

------------------------------
-- Table : personnage_capacite
DROP TABLE IF EXISTS personnage_capacite;

CREATE TABLE personnage_capacite (
    perso_id    INTEGER REFERENCES personnage (perso_id),
    capacite_id INTEGER REFERENCES capacite (capacite_id) 
);

----------------------------
-- Table : personnage_equipe
DROP TABLE IF EXISTS personnage_equipe;

CREATE TABLE personnage_equipe (
    perso_id  INTEGER REFERENCES personnage (perso_id),
    equipe_id INTEGER REFERENCES equipe (equipe_id) 
);

----------------------------------
-- Table : personnage_equipe_livre
DROP TABLE IF EXISTS personnage_equipe_livre;

CREATE TABLE personnage_equipe_livre (
    perso_id  INTEGER REFERENCES personnage (perso_id),
    equipe_id INTEGER REFERENCES equipe (equipe_id),
    livre_id  INTEGER REFERENCES livre (livre_id) 
);



-----------------------------
-- Remplissage des tables
-----------------------------
-----------------------------
-- Remplissage table : auteur
INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       1,
                       'Mignola',
                       'Mike'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       2,
                       'Claremont',
                       'Chris'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       3,
                       'Byrne',
                       'John'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       4,
                       'Austin',
                       'Terry'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       5,
                       'Miller',
                       'Frank'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       6,
                       'Janson',
                       'Klaus'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       7,
                       'Mazzucchelli',
                       'David'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       8,
                       'De Matteis',
                       'John Marc'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       9,
                       'Bagley',
                       'Mark'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       10,
                       'Farmer',
                       'Mark'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       11,
                       'Nolan',
                       'Graham'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       12,
                       'Kesel',
                       'Karl'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       13,
                       'Choi',
                       'Brandon'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       14,
                       'Lee',
                       'Jim'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       15,
                       'Williams',
                       'Scott'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       16,
                       'Mac Farlane',
                       'Todd'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       17,
                       'Kindt',
                       'Matt'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       18,
                       'Mann',
                       'Clay'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       19,
                       'Wagner',
                       'Matt'
                   );

INSERT INTO auteur (
                       auteur_id,
                       auteur_nom,
                       auteur_prenom
                   )
                   VALUES (
                       20,
                       'Francavilla',
                       'Francesco'
                   );

-------------------------------
-- Remplissage table : capacite
INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         1,
                         'Super-force',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         2,
                         'Super-force',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         3,
                         'Facteur guérissant',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         4,
                         'Rafale Optique',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         5,
                         'Téléportation',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         6,
                         'Télépathie',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         7,
                         'Télékinésie',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         8,
                         'Vol',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         9,
                         'Vol',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         10,
                         'Super-agilité',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         11,
                         'Super-agilité',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         12,
                         'Dématérialisation',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         13,
                         'Sens surdéveloppés',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         14,
                         'Sens surdéveloppés',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         15,
                         'Arts martiaux',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         16,
                         'Maîtrise du feu',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         17,
                         'Maîtrise du feu',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         18,
                         'Elasticité',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         19,
                         'Invisibilité',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         20,
                         'Champ de force',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         21,
                         'Pouvoir cosmique',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         22,
                         'Armure technologique',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         23,
                         'Intelligence surhumaine',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         24,
                         'Invulnérabilité',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         25,
                         'Invulnérabilité',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         26,
                         'Contrôle de la densité',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         27,
                         'Désintégration',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         28,
                         'Transmorphisme',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         29,
                         'Transmorphisme',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         30,
                         'Précognition',
                         'Inné'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         31,
                         'Symbiote extraterrestre',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         32,
                         'Habileté aux armes à feu',
                         'Acquis'
                     );

INSERT INTO capacite (
                         capacite_id,
                         capacite_nom,
                         capacite_categorie
                     )
                     VALUES (
                         33,
                         'Habilté aux armes blanches',
                         'Acquis'
                     );

---------------------------------
-- Remplissage table : couverture
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           1,
                           'image1',
                           1,
                           1,
                           1994,
                           1
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           2,
                           'image2',
                           1,
                           1,
                           1995,
                           2
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           3,
                           'image3',
                           1,
                           1,
                           1996,
                           3
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           4,
                           'image4',
                           3,
                           4,
                           1980,
                           4
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           5,
                           'image5',
                           3,
                           4,
                           1981,
                           5
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           6,
                           'image6',
                           3,
                           3,
                           1989,
                           6
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           7,
                           'image7',
                           5,
                           5,
                           1986,
                           7
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           8,
                           'image8',
                           7,
                           7,
                           1987,
                           8
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           9,
                           'image9',
                           7,
                           7,
                           1986,
                           9
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           10,
                           'image10',
                           5,
                           6,
                           1981,
                           10
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           11,
                           'image11',
                           5,
                           6,
                           1982,
                           11
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           12,
                           'image12',
                           5,
                           6,
                           1983,
                           12
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           13,
                           'image13',
                           9,
                           10,
                           1995,
                           13
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           14,
                           'image14',
                           11,
                           12,
                           1997,
                           14
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           15,
                           'image15',
                           14,
                           15,
                           1995,
                           15
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           16,
                           'image16',
                           14,
                           15,
                           1992,
                           16
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           17,
                           'image17',
                           16,
                           16,
                           1992,
                           17
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           18,
                           'image18',
                           18,
                           18,
                           2016,
                           18
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           19,
                           'image19',
                           20,
                           20,
                           2009,
                           19
                       );

INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           20,
                           'image20',
                           5,
                           5,
                           1998,
                           20
                       );






INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           21,
                           'une_image',
                           7,
                           6,
                           1981,
                           null
                       );
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           22,
                           'deuxieme_image',
                           7,
                           6,
                           1982,
                           null
                       );
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           23,
                           'troisieme_image',
                           7,
                           6,
                           1983,
                           null
                       );
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           24,
                           'quatrieme_image',
                           5,
                           6,
                           1986,
                           null
                       );
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           25,
                           'cinquieme_image',
                           5,
                           5,
                           1987,
                           null
                       );
INSERT INTO couverture (
                           couverture_id,
                           couverture_image,    
                           couverture_dessinateur,
                           couverture_encreur,
                           couverture_date,
                           livre_id
                       )
                       VALUES (
                           26,
                           'sixieme_image',
                           14,
                           15,
                           1992,
                           null
                       );


------------------------------
-- Remplissage table : editeur
INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        1,
                        'Marvel Comics'
                    );

INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        2,
                        'DC Comics'
                    );

INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        3,
                        'Dark Horse'
                    );

INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        4,
                        'Image Comics'
                    );

INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        5,
                        'Dynamite'
                    );

INSERT INTO editeur (
                        editeur_id,
                        editeur_nom
                    )
                    VALUES (
                        6,
                        'Valiant'
                    );

-----------------------------
-- Remplissage table : equipe
INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       1,
                       'Héros solitaire',
                       'héros',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       2,
                       'Vilain solitaire',
                       'vilain',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       3,
                       'BPRD',
                       'héros',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       4,
                       'X-Men',
                       'héros',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       5,
                       'Fantastic Four',
                       'héros',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       6,
                       'Brotherhood of Evil Mutants',
                       'vilain',
                       'non'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       7,
                       'Batman et Spider-Man',
                       'héros',
                       'oui'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       8,
                       'Joker et Carnage',
                       'vilain',
                       'oui'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       9,
                       'Kingpin et Ra''s Al Ghul',
                       'vilain',
                       'oui'
                   );

INSERT INTO equipe (
                       equipe_id,
                       equipe_nom,
                       equipe_statut,
                       equipe_temporaire
                   )
                   VALUES (
                       10,
                       'Wildcats',
                       'héros',
                       'non'
                   );

----------------------------
-- Remplissage table : livre
INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      1,
                      'Hellboy - Seeds of destruction',
                      'Un démon rouge à gros bras',
                      1,
                      1,
                      1,
                      354541563536,
                      1994
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      2,
                      'Hellboy - Wake the Devil',
                      'Un démon rouge à gros bras (droit)',
                      1,
                      1,
                      1,
                      3654236423243541,
                      1995
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      3,
                      'Hellboy - Almost Colossus',
                      'Un démon rouge à gros bras (toujours le droit)',
                      1,
                      1,
                      1,
                      36846534121,
                      1996
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      4,
                      'X-Men Dark Phoenix Saga',
                      'Les X-Men combattent l''une des leurs, tombée du côté obscur',
                      2,
                      3,
                      4,
                      1687463514321,
                      1980
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      5,
                      'X-Men Days of Future Past',
                      'Kitty Pryde remonte le temps pour empêcher l''extermination des mutants par les sentinelles',
                      2,
                      3,
                      4,
                      1867465431,
                      1981
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      6,
                      'The Trial of Galactus',
                      'Les Quatre Fantastiques sauvent Galactus et doivent se justifier devant un tribunal cosmique',
                      3,
                      3,
                      3,
                      1987465321564,
                      1989
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      7,
                      'Batman - The Dark Knight Returns',
                      'A 50 ans, 10 ans après avoir pris sa retraite, Batman revient sauver Gotham City.',
                      5,
                      5,
                      6,
                      287413542426,
                      1986
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      8,
                      'Batman : Year One',
                      'La première année d''apprentissage de l''homme chauve souris en tant que justicier de Gotham',
                      5,
                      7,
                      7,
                      28747635148,
                      1987
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      9,
                      'Daredevil : Born Again',
                      'L''identité du justicier aveugle est révélée à son pire ennemi, qui lui fait alors vivre une descente aux enfers… Mais l''homme sans peur n''abandonne jamais !',
                      5,
                      7,
                      7,
                      1698712541,
                      1986
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      10,
                      'Daredevil Frank Miller Omnibus Volume 1',
                      'Le début du run de Frank Miller sur le justicier aveugle',
                      5,
                      5,
                      6,
                      1698716353,
                      1981
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      11,
                      'Daredevil Frank Miller Omnibus Volume 2',
                      'L''arrivée d''Elektra dans les aventures de Daredevil et le début de ses rivalités avec le Kingpin et Bullseye',
                      5,
                      5,
                      6,
                      1674152452314,
                      1982
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      12,
                      'Daredevil Frank Miller Omnibus Volume 3',
                      'La fin du conflit entre Elektra, la Main et Daredevil',
                      5,
                      5,
                      6,
                      1618741325,
                      1983
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      13,
                      'Spider-Man and Batman: Disordered Minds',
                      'Le super-vilain Carnage est guéri par le Docteur Kafka de l''institut Ravencroft mais le Joker vient semer le trouble et il faudra l''alliance de Batman et Spider-Man pour arrêter lesymbiote écarlate et le prince du Crime.',
                      8,
                      9,
                      10,
                      18764556411654,
                      1995
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      14,
                      'Batman/Spider-Man: New Age Dawning',
                      'Face au Kingpin et Ra''s Al Ghul !',
                      8,
                      11,
                      12,
                      26874545432,
                      1997
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      15,
                      'Wildcats : Covert Action Teams',
                      'Sur Terre, deux races aliens, Kheroubims et Daemonites, se livrent une guerre secrète',
                      13,
                      14,
                      15,
                      4987456413,
                      1995
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      16,
                      'X-Men : Mutant Genesis',
                      'Le retour de Magnéto, à la tête d''une nouvelle faction : les Acolytes, face aux mutants de Charles Xavier !',
                      2,
                      14,
                      15,
                      1867451651324,
                      1992
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      17,
                      'Spawn : beginnings',
                      'Les débuts du héros maudit de Todd McFarlane',
                      16,
                      16,
                      16,
                      454216534,
                      1992
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      18,
                      'Ninjak : Weaponeer',
                      'Une aventure du meilleur ninja-espion du MI-6',
                      17,
                      18,
                      18,
                      669987463546,
                      2016
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      19,
                      'Zorro : Year One',
                      'Les origines du vengeur masqué',
                      19,
                      20,
                      21,
                      564541254,
                      2009
                  );

INSERT INTO livre (
                      livre_id,
                      livre_titre,
                      livre_contenu,
                      livre_scenariste,
                      livre_dessinateur,
                      livre_encreur,
                      livre_reference_editeur,
                      livre_date
                  )
                  VALUES (
                      20,
                      '300',
                      'La version romancée de la bataille des 300 Spartiates au col des Thermopyles',
                      5,
                      5,
                      5,
                      36857463541,
                      1998
                  );

---------------------------------
-- Remplissage table : personnage
INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           11,
                           'Wayne',
                           'Bruce',
                           'Batman'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           12,
                           'Kent',
                           'Clark',
                           'Superman'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           13,
                           'Jones',
                           'Carrie Kelley',
                           'Robin III'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           14,
                           '',
                           '',
                           'The Joker'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           15,
                           'Dent',
                           'Harvey',
                           'Two-Face'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           16,
                           'Richards',
                           'Reed',
                           'Mister Fantastic'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           17,
                           'Storm-Richards',
                           'Susan',
                           'Invisible Woman'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           18,
                           'Storm',
                           'Johnny',
                           'Human Torch'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           19,
                           'Grimm',
                           'Ben',
                           'The Thing'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           20,
                           'Radd',
                           'Norrin',
                           'Silver Surfer'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           21,
                           '',
                           'Tyrros',
                           'Terrax the Tamer'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           22,
                           'Von Doom',
                           'Victor',
                           'Doctor Doom'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           23,
                           '',
                           'Gallen',
                           'Galactus'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           24,
                           'Murdock',
                           'Matt',
                           'Daredevil'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           25,
                           'Fisk',
                           'Wilson',
                           'Kingpin'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           26,
                           'Pondexter',
                           'Lester',
                           'Bullseye'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           27,
                           'Natchios',
                           'Elektra',
                           'Elektra'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           28,
                           'Darkholme',
                           'Raven',
                           'Mystique'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           29,
                           'Adler',
                           'Irène',
                           'Destiny'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           30,
                           'Dukes',
                           'Fred',
                           'Blob'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           31,
                           'Allerdyce',
                           'John',
                           'Pyro'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           32,
                           'Petrakis',
                           'Dominikos',
                           'Avalanche'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           33,
                           'Parker',
                           'Peter',
                           'Spider-Man'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           34,
                           'Al Ghul',
                           'Ra''s',
                           'The Demon'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           35,
                           'Cassady',
                           'Claetus',
                           'Carnage'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           36,
                           'Marlowe',
                           'Jacob',
                           'Lors Emp'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           37,
                           'Cash',
                           'Cole',
                           'Grifter'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           38,
                           '',
                           'Zanna',
                           'Zealot'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           39,
                           'Kitaen',
                           'Priscilla',
                           'Voodoo'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           40,
                           'Bryce',
                           'Reno',
                           'Warblade'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           41,
                           'Marlowe',
                           'Jack',
                           'Spartan'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           42,
                           'Stone',
                           'Jeremy',
                           'Maul'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           43,
                           'Tereshkova',
                           'Adrianna',
                           'Void'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           44,
                           'Simmons',
                           'Al',
                           'Spawn'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           45,
                           'King',
                           'Colin',
                           'Ninjak'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           46,
                           'De La Vega',
                           'Diego',
                           'Zorro'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           47,
                           'Of Sparta',
                           'Leonidas',
                           'King Leonidas'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           1,
                           '',
                           '',
                           'Hellboy'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           2,
                           'Grey',
                           'Jean',
                           'Phoenix'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           3,
                           'Summers',
                           'Scott',
                           'Cyclops'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           4,
                           '',
                           'Logan',
                           'Wolverine'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           5,
                           'Wagner',
                           'Kurt',
                           'Nightcrawler'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           6,
                           'Worthington',
                           'Warren',
                           'Angel'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           7,
                           'Mc Coy',
                           'Henry',
                           'Beast'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           8,
                           'Raspoutine',
                           'Peter',
                           'Colossus'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           9,
                           'Xavier',
                           'Charles',
                           'Professor X'
                       );

INSERT INTO personnage (
                           perso_id,
                           perso_nom,
                           perso_prenom,
                           perso_alias
                       )
                       VALUES (
                           10,
                           'Pryde',
                           'Kitty',
                           'Shadowcat'
                       );

-------------------------------------
-- Remplissage table : edition_auteur
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           1
                       );

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           2
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           3
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           4
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           5
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           6
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           7
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           8
                       );   
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           9
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           10
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           12
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           14
                       );                       
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           15
                       );    
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           16
                       );                       
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           18
                       );    
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           1,
                           20
                       );    
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           2
                       );                       
       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           3
                       ); 
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           4
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           5
                       );   
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           6
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           7
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           8
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           9
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           10
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           11
                       );                        
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           12
                       ); 
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           14
                       ); 
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           15
                       ); 
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           18
                       ); 
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           2,
                           19
                       );    
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           3,
                           1
                       );                        

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           3,
                           3
                       );

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           3,
                           5
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           3,
                           19
                       );

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           4,
                           13
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           4,
                           14
                       );

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           4,
                           15
                       );

INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           4,
                           16
                       );
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           5,
                           20
                       );    
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           6,
                           17
                       ); 
                       
INSERT INTO edition_auteur (
                            edition_id,
                            auteur_id
                       )
                       VALUES (
                           6,
                           18
                       );                        

------------------------------------
-- Remplissage table : livre_editeur
INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           1,
                           3
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           2,
                           3
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           3,
                           3
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           4,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           5,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           6,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           7,
                           2
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           8,
                           2
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           9,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           10,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           11,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           12,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           13,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           13,
                           2
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           14,
                           4
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           15,
                           1
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           16,
                           4
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           17,
                           6
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           18,
                           5
                       );

INSERT INTO livre_editeur (
                            livre_id,
                            editeur_id
                       )
                       VALUES (
                           20,
                           3
                       );

------------------------------------------
-- Remplissage table : personnage_capacite
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           1,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           1,
                           32
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           1,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           2,
                           6
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           2,
                           7
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           2,
                           8
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           2,
                           21
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           3,
                           4
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           3,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           4,
                           3
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           4,
                           13
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           4,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           4,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           5,
                           5
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           5,
                           10
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           5,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           5,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           6,
                           8
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           6,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           7,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           7,
                           10
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           7,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           8,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           8,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           8,
                           24
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           9,
                           6
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           9,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           10,
                           12
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           10,
                           15
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           10,
                           24
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           11,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           11,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           12,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           12,
                           4
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           12,
                           8
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           12,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           12,
                           24
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           13,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           13,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           14,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           14,
                           23
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           14,
                           32
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           15,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           15,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           15,
                           32
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           16,
                           18
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           16,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           17,
                           19
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           17,
                           20
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           18,
                           9
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           18,
                           17
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           19,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           19,
                           25
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           20,
                           2
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           20,
                           9
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           20,
                           25
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           20,
                           21
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           21,
                           2
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           21,
                           21
                       );
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           22,
                           2
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           22,
                           9
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           22,
                           22
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           22,
                           23
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           23,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           23,
                           6
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           23,
                           7
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           23,
                           21
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           24,
                           11
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           24,
                           14
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           24,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           25,
                           2
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           25,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           25,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           26,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           26,
                           32
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           26,
                           11
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           26,
                           23
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           27,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           27,
                           11
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           27,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           27,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           28,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           28,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           28,
                           28
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           28,
                           23
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           29,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           29,
                           30
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           30,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           30,
                           24
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           30,
                           26
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           31,
                           16
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           32,
                           27
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           33,
                           2
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           33,
                           11
                       ); 
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           33,
                           15
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           34,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           34,
                           30
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           35,
                           31
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           36,
                           23
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           36,
                           32
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           37,
                           32
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           37,
                           3
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           37,
                           11
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           38,
                           20
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           38,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           38,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           39,
                           16
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           39,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           39,
                           28
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           40,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           40,
                           18
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           40,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           41,
                           8
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           41,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           41,
                           23
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           41,
                           24
                       ); 

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           42,
                           1
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           42,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           43,
                           5
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           43,
                           6
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           43,
                           23
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           44,
                           5
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           44,
                           29
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           44,
                           31
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           44,
                           32
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           45,
                           22
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           45,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           45,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           45,
                           23
                       );
                       
INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           45,
                           11
                       );                       

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           46,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           46,
                           33
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           46,
                           15
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           47,
                           23
                       );

INSERT INTO personnage_capacite (
                            perso_id,
                            capacite_id
                       )
                       VALUES (
                           47,
                           33
                       );

----------------------------------------
-- Remplissage table : personnage_equipe
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           1,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           1,
                           3
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           2,
                           4
                       );
                       
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           2,
                           6
                       );                       

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           3,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           4,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           4,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           5,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           6,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           7,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           8,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           9,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           10,
                           4
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           11,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           11,
                           7
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           12,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           13,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           14,
                           2
                       );
                       
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           14,
                           8
                       );                       

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           15,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           16,
                           5
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           17,
                           5
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           18,
                           5
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           19,
                           5
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           20,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           21,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           22,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           23,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           24,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           25,
                           2
                       );


INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           25,
                           9
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           26,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           27,
                           2
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           28,
                           6
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           29,
                           6
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           30,
                           6
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           31,
                           6
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           32,
                           6
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           33,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           33,
                           7
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           34,
                           2
                       );
                       
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           34,
                           9
                       );                       

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           35,
                           2
                       );
                       
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           35,
                           8
                       );                       

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           36,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           37,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           38,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           39,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           40,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           41,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           42,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           43,
                           10
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           44,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           45,
                           1
                       );

INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           46,
                           1
                       );
                       
INSERT INTO personnage_equipe (
                            perso_id,
                            equipe_id
                       )
                       VALUES (
                           47,
                           1
                       );

----------------------------------------------
-- Remplissage table : personnage_equipe_livre
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           1,
                           3,
                           1
                       );

INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           1,
                           3,
                           2
                       );
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           1,
                           1,
                           3
                       );

INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           3,
                           4,
                           4
                       );
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           4,
                           4,
                           4
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           5,
                           4,
                           4
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           6,
                           4,
                           4
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           7,
                           4,
                           4
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           8,
                           4,
                           4
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           9,
                           4,
                           4
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           2,
                           6,
                           4
                       );                      
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           28,
                           6,
                           4
                       );                          
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           29,
                           6,
                           4
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           30,
                           6,
                           4
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           31,
                           6,
                           4
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           32,
                           6,
                           4
                       );                 
 
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           3,
                           4,
                           5
                       );
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           4,
                           4,
                           5
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           5,
                           4,
                           5
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           6,
                           4,
                           5
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           7,
                           4,
                           5
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           8,
                           4,
                           5
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           9,
                           4,
                           5
                       ); 
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           10,
                           4,
                           5
                       );                       
                                     
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           28,
                           6,
                           5
                       );                          
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           29,
                           6,
                           5
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           30,
                           6,
                           5
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           31,
                           6,
                           5
                       );                 
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           32,
                           6,
                           5
                       );                    
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           23,
                           2,
                           6
                       );              
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           16,
                           5,
                           6
                       );  
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           17,
                           5,
                           6
                       );              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           18,
                           5,
                           6
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           19,
                           5,
                           6
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           22,
                           2,
                           6
                       ); 
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           21,
                           2,
                           6
                       );              
                      
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           11,
                           1,
                           7
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           14,
                           2,
                           7
                       );  
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           15,
                           2,
                           7
                       );      
        
 INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           11,
                           1,
                           8
                       );       
             
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           24,
                           1,
                           9
                       );        
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           25,
                           1,
                           9
                       );          
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           24,
                           1,
                           10
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           25,
                           2,
                           10
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           26,
                           2,
                           10
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           27,
                           2,
                           10
                       );             
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           24,
                           1,
                           11
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           25,
                           2,
                           11
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           26,
                           2,
                           11
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           27,
                           2,
                           11
                       );      
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           24,
                           1,
                           12
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           25,
                           2,
                           12
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           26,
                           2,
                           12
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           27,
                           2,
                           12
                       );              
              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           11,
                           7,
                           13
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           33,
                           7,
                           13
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           14,
                           8,
                           13
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           35,
                           8,
                           13
                       );              
               
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           11,
                           7,
                           14
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           33,
                           7,
                           14
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           25,
                           9,
                           14
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           34,
                           9,
                           14
                       );            
            
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           36,
                           10,
                           15
                       );      
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           37,
                           10,
                           15
                       );   
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           38,
                           10,
                           15
                       );  
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           39,
                           10,
                           15
                       );                      
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           40,
                           10,
                           15
                       );      
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           41,
                           10,
                           15
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           42,
                           10,
                           15
                       );       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           43,
                           10,
                           15
                       );                       
                                              
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           2,
                           4,
                           16
                       );                 
                 
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           3,
                           4,
                           16
                       );
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           4,
                           4,
                           16
                       );     
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           6,
                           4,
                           16
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           7,
                           4,
                           16
                       );    
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           8,
                           4,
                           16
                       );                       
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           9,
                           4,
                           16
                       );                       
       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           44,
                           1,
                           17
                       );       
       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           45,
                           1,
                           18
                       );
                       
INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           46,
                           1,
                           19
                       );       

INSERT INTO personnage_equipe_livre (
                            perso_id,
                            equipe_id,
                            livre_id
                       )
                       VALUES (
                           47,
                           1,
                           20
                       );



----------------------
-- Requêtes SQL
----------------------
-----------------
-- requête LIKE : typiquement faire une recherche sur un auteur dont on ne se rappelle plus du nom exact 
-- Exemple : mais si tu te souviens, comment il s'appelle, y a "an" dedans
SELECT * FROM auteur WHERE auteur_nom LIKE '%an%';


---------------------
-- requête GROUP BY : compter combien de livres sont sortis en les regroupant par année
SELECT
    livre_date,
	COUNT(livre_date)
FROM
	livre
GROUP BY
	livre_date;
    

---------------------
-- Autre requête Like pour faire un différentiel visuel entre les 2 requêtes de date   
-- Exemple : Un utilisateur qui recherche un livre avec batman, mais comme certain SGBDR sont sensible à la casse avec LIKE, on peut mettre d'abord tous les titres en minuscule :
-- SELECT livre_titre FROM livre WHERE lower(livre_titre) LIKE '%BATman%';
SELECT livre_titre FROM livre WHERE livre_titre LIKE '%BATman%';   
   
   
------------------------   
-- requête avec Having : afficher les personnages ayant plus de 3 capacités et donner leur nombre par personnage
SELECT
    personnage.perso_alias,
	COUNT(PC.capacite_id)
FROM
	personnage_capacite AS PC
JOIN personnage
    ON personnage.perso_id = PC.perso_id   
GROUP BY
	personnage.perso_alias
HAVING
    count(PC.capacite_id) > 3;


----------------------
-- requête avec Join : lier toutes les informations présentent dans les tables
-- Exemple : typique d'une page ou l'on affiche toutes les livres par leur titre et mettre les noms du scenariste, du dessinateur et de l'encreur.
SELECT 
    livre_titre,
    A1.auteur_nom AS scenariste,
    A2.auteur_nom AS dessinateur,
    A3.auteur_nom AS encreur
FROM 
    livre AS L
INNER JOIN auteur AS A1
    ON A1.auteur_id = L.livre_scenariste
INNER JOIN auteur AS A2
    ON A2.auteur_id = L.livre_dessinateur
INNER JOIN auteur AS A3
    ON A3.auteur_id = L.livre_encreur;


----------------------------
-- requête avec Outer Join : Alors là on en a pas mais on pourrait imaginer que dans le champs : couverture_image on a une image.
-- Avec cette requête il serait donc possible de voir les couvertures de livre en base de donnée mais qui n'ont pas encore été attribuées à un livre ... un peu comme des essais qui pourraient être gardé pour être utilisés plus tard.
SELECT 
    C.couverture_id,
    C.couverture_image,
    L.livre_id
FROM couverture AS C
LEFT OUTER JOIN livre AS L
    ON C.livre_id = L.livre_id;





COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
