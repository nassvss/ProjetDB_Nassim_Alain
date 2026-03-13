-- ============================================================
-- PROJET SDD - Gestion Cinématographique
-- Fichier 2 : Contraintes de validation (règles métier)
-- ============================================================
-- Ces contraintes CHECK complètent les contraintes d'intégrité
-- référentielle définies dans 1_creation.sql.
-- Elles couvrent : domaines de valeurs, formats, bornes,
-- cohérence temporelle et règles métier issues de l'étape 1.
-- ============================================================


-- ============================================================
-- CONTRAINTES SUR FILM
-- ============================================================

-- La durée d'un film doit être strictement positive (> 0 minutes)
ALTER TABLE FILM
    ADD CONSTRAINT CHK_FILM_DUREE
    CHECK (Duree > 0);

-- La durée d'un film est réaliste (entre 1 minute et 600 minutes)
ALTER TABLE FILM
    ADD CONSTRAINT CHK_FILM_DUREE_MAX
    CHECK (Duree <= 600);

-- Un film ne peut pas être la suite de lui-même (auto-référence interdite)
ALTER TABLE FILM
    ADD CONSTRAINT CHK_FILM_PAS_SUITE_DE_SOI
    CHECK (id_film_precedent IS NULL OR id_film_precedent <> id_film);

-- Le genre doit appartenir à une liste de valeurs connues
ALTER TABLE FILM
    ADD CONSTRAINT CHK_FILM_GENRE
    CHECK (Genre IN (
        'Action', 'Aventure', 'Animation', 'Comédie', 'Documentaire',
        'Drame', 'Fantastique', 'Horreur', 'Romance', 'Science-Fiction',
        'Thriller', 'Western', 'Policier', 'Biopic', 'Musical'
    ));

-- La date de sortie ne peut pas être antérieure au 28/12/1895
-- (date de la première séance publique de cinéma)
ALTER TABLE FILM
    ADD CONSTRAINT CHK_FILM_DATE_SORTIE_MIN
    CHECK (Date_sortie >= '1895-12-28');

-- Note : aucune contrainte MAX sur Date_sortie
-- Un cinéma doit pouvoir enregistrer des films à sortie future (préprogrammation)


-- ============================================================
-- CONTRAINTES SUR SALLE
-- ============================================================

-- Le numéro de salle doit être strictement positif
ALTER TABLE SALLE
    ADD CONSTRAINT CHK_SALLE_NUMERO
    CHECK (numero_salle > 0);

-- La capacité d'une salle doit être strictement positive
ALTER TABLE SALLE
    ADD CONSTRAINT CHK_SALLE_CAPACITE
    CHECK (Capacite > 0);

-- La capacité maximale est fixée à 1000 sièges
ALTER TABLE SALLE
    ADD CONSTRAINT CHK_SALLE_CAPACITE_MAX
    CHECK (Capacite <= 1000);

-- Le type de projecteur doit être l'une des valeurs autorisées
ALTER TABLE SALLE
    ADD CONSTRAINT CHK_SALLE_TYPE_PROJECTEUR
    CHECK (Type_projecteur IN ('Laser', 'Numérique', '3D', 'IMAX', '4DX'));


-- ============================================================
-- CONTRAINTES SUR EMPLOYE
-- ============================================================

-- Le rôle doit correspondre à un poste existant dans l'entreprise
ALTER TABLE EMPLOYE
    ADD CONSTRAINT CHK_EMPLOYE_ROLE
    CHECK (Role IN ('Projectionniste', 'Accueil', 'Manager', 'Technicien', 'Caissier'));

-- La date d'embauche ne peut pas être antérieure à 1900
ALTER TABLE EMPLOYE
    ADD CONSTRAINT CHK_EMPLOYE_DATE_EMBAUCHE_MIN
    CHECK (Date_embauche >= '1900-01-01');

-- La date d'embauche ne peut pas être dans le futur
ALTER TABLE EMPLOYE
    ADD CONSTRAINT CHK_EMPLOYE_DATE_EMBAUCHE
    CHECK (Date_embauche <= CURRENT_DATE);

-- Le nom et prénom ne peuvent pas être vides (chaîne non vide)
ALTER TABLE EMPLOYE
    ADD CONSTRAINT CHK_EMPLOYE_NOM
    CHECK (LENGTH(TRIM(Nom)) > 0);

ALTER TABLE EMPLOYE
    ADD CONSTRAINT CHK_EMPLOYE_PRENOM
    CHECK (LENGTH(TRIM(Prenom)) > 0);


-- ============================================================
-- CONTRAINTES SUR CLIENT
-- ============================================================

-- Le nom et prénom ne peuvent pas être vides
ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_NOM
    CHECK (LENGTH(TRIM(Nom)) > 0);

ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_PRENOM
    CHECK (LENGTH(TRIM(Prenom)) > 0);

-- L'adresse email doit contenir un '@' et un '.' (format minimal)
ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_EMAIL_FORMAT
    CHECK (
        Email LIKE '%@%.%'
        AND Email NOT LIKE '@%'
        AND Email NOT LIKE '%@'
    );

-- La date de naissance ne peut pas être dans le futur
ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_DATE_NAISSANCE
    CHECK (Date_naissance < CURRENT_DATE);

-- L'âge minimum pour s'inscrire est 12 ans (syntaxe MySQL)
ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_AGE_MIN
    CHECK (Date_naissance <= CURRENT_DATE - INTERVAL 12 YEAR);

-- Les points de fidélité ne peuvent pas être négatifs
ALTER TABLE CLIENT
    ADD CONSTRAINT CHK_CLIENT_POINTS
    CHECK (Points_fidelite >= 0);


-- ============================================================
-- CONTRAINTES SUR SEANCE
-- ============================================================

-- Le prix de base doit être strictement positif
ALTER TABLE SEANCE
    ADD CONSTRAINT CHK_SEANCE_PRIX
    CHECK (Prix_base > 0);

-- Le prix de base est réaliste (max 50 €)
ALTER TABLE SEANCE
    ADD CONSTRAINT CHK_SEANCE_PRIX_MAX
    CHECK (Prix_base <= 50.00);

-- La date de séance ne peut pas être antérieure au 01/01/2000
-- (borne métier raisonnable pour le système)
ALTER TABLE SEANCE
    ADD CONSTRAINT CHK_SEANCE_DATE_MIN
    CHECK (Date_seance >= '2000-01-01');


-- ============================================================
-- CONTRAINTES SUR BILLET
-- ============================================================

-- Le moyen de paiement doit appartenir aux valeurs autorisées
ALTER TABLE BILLET
    ADD CONSTRAINT CHK_BILLET_MOYEN_PAIEMENT
    CHECK (Moyen_paiement IN (
        'Carte bancaire', 'Espèces', 'Chèque',
        'Carte cadeau', 'Ticket cinéma', 'PayPal',
        'Pass Culture', 'Carte de fidélité'
    ));

-- La rangée du siège doit être une ou deux lettres majuscules (ex : A, BC)
-- Syntaxe MySQL (REGEXP)
ALTER TABLE BILLET
    ADD CONSTRAINT CHK_BILLET_RANGEE
    CHECK (Rangee_siege REGEXP '^[A-Z]{1,2}$');

-- Le numéro de siège doit être strictement positif
ALTER TABLE BILLET
    ADD CONSTRAINT CHK_BILLET_NUMERO_SIEGE
    CHECK (Numero_siege > 0);

-- Le numéro de siège ne dépasse pas 999 (cohérent avec la taille = 3 chiffres)
ALTER TABLE BILLET
    ADD CONSTRAINT CHK_BILLET_NUMERO_SIEGE_MAX
    CHECK (Numero_siege <= 999);

-- La date d'achat ne peut pas être dans le futur
ALTER TABLE BILLET
    ADD CONSTRAINT CHK_BILLET_DATE_ACHAT
    CHECK (Date_achat <= CURRENT_DATE);
