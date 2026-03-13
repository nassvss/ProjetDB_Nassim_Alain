-- ============================================================
-- PROJET SDD - Gestion Cinématographique
-- Fichier 1 : Création des tables avec contraintes d'intégrité
-- ============================================================

-- Suppression des tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS BILLET;
DROP TABLE IF EXISTS SEANCE;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS EMPLOYE;
DROP TABLE IF EXISTS SALLE;
DROP TABLE IF EXISTS FILM;


-- ============================================================
-- TABLE FILM
-- Association récursive : un film peut être la suite d'un autre
-- ============================================================
CREATE TABLE FILM (
    id_film             VARCHAR(10)  NOT NULL,
    Titre               VARCHAR(100) NOT NULL,
    Duree               INT          NOT NULL,       -- en minutes
    Genre               VARCHAR(30)  NOT NULL,
    Date_sortie         DATE         NOT NULL,
    Synopsis            VARCHAR(500),
    id_film_precedent   VARCHAR(10)  DEFAULT NULL,   -- clé étrangère récursive (suite de)

    CONSTRAINT PK_FILM PRIMARY KEY (id_film),

    -- UNIQUE garantit la cardinalité 0,1 : un film ne peut avoir qu'une seule suite directe
    CONSTRAINT UQ_FILM_PRECEDENT UNIQUE (id_film_precedent),

    CONSTRAINT FK_FILM_SUITE FOREIGN KEY (id_film_precedent)
        REFERENCES FILM(id_film)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- ============================================================
-- TABLE SALLE
-- ============================================================
CREATE TABLE SALLE (
    numero_salle    INT         NOT NULL,
    Capacite        INT         NOT NULL,    -- nombre de sièges
    Type_projecteur VARCHAR(20) NOT NULL,    -- Laser, Numérique, 3D, IMAX, 4DX

    CONSTRAINT PK_SALLE PRIMARY KEY (numero_salle)
);


-- ============================================================
-- TABLE EMPLOYE
-- ============================================================
CREATE TABLE EMPLOYE (
    id_employe    VARCHAR(10) NOT NULL,
    Nom           VARCHAR(50) NOT NULL,
    Prenom        VARCHAR(50) NOT NULL,
    Role          VARCHAR(30) NOT NULL,
    Date_embauche DATE        NOT NULL,

    CONSTRAINT PK_EMPLOYE PRIMARY KEY (id_employe)
);


-- ============================================================
-- TABLE CLIENT
-- ============================================================
CREATE TABLE CLIENT (
    id_client       VARCHAR(10)  NOT NULL,
    Nom             VARCHAR(50)  NOT NULL,
    Prenom          VARCHAR(50)  NOT NULL,
    Email           VARCHAR(100) NOT NULL,
    Date_naissance  DATE         NOT NULL,
    Points_fidelite INT          NOT NULL DEFAULT 0,

    CONSTRAINT PK_CLIENT PRIMARY KEY (id_client),
    CONSTRAINT UQ_CLIENT_EMAIL UNIQUE (Email)
);


-- ============================================================
-- TABLE SEANCE
-- Association ternaire PROJETER : EMPLOYE + SALLE + SEANCE
-- ============================================================
CREATE TABLE SEANCE (
    numero_seance VARCHAR(10)  NOT NULL,
    Date_seance   DATE         NOT NULL,
    Heure_debut   TIME         NOT NULL,
    Prix_base     DECIMAL(5,2) NOT NULL,
    numero_salle  INT          NOT NULL,
    id_employe    VARCHAR(10)  NOT NULL,
    id_film       VARCHAR(10)  NOT NULL,

    CONSTRAINT PK_SEANCE PRIMARY KEY (numero_seance),

    -- FK vers SALLE (suppression en cascade vers les séances)
    CONSTRAINT FK_SEANCE_SALLE FOREIGN KEY (numero_salle)
        REFERENCES SALLE(numero_salle)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- FK vers EMPLOYE
    CONSTRAINT FK_SEANCE_EMPLOYE FOREIGN KEY (id_employe)
        REFERENCES EMPLOYE(id_employe)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- FK vers FILM
    CONSTRAINT FK_SEANCE_FILM FOREIGN KEY (id_film)
        REFERENCES FILM(id_film)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ============================================================
-- TABLE BILLET
-- Associations RESERVER (SEANCE) et ACHETER (CLIENT)
-- ============================================================
CREATE TABLE BILLET (
    numero_billet  VARCHAR(12) NOT NULL,
    Date_achat     DATE        NOT NULL,
    Rangee_siege   VARCHAR(2)  NOT NULL,
    Numero_siege   INT         NOT NULL,
    Moyen_paiement VARCHAR(20) NOT NULL,
    id_client      VARCHAR(10) NOT NULL,
    numero_seance  VARCHAR(10) NOT NULL,

    CONSTRAINT PK_BILLET PRIMARY KEY (numero_billet),

    -- FK vers CLIENT
    CONSTRAINT FK_BILLET_CLIENT FOREIGN KEY (id_client)
        REFERENCES CLIENT(id_client)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- FK vers SEANCE
    CONSTRAINT FK_BILLET_SEANCE FOREIGN KEY (numero_seance)
        REFERENCES SEANCE(numero_seance)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- Un siège ne peut être réservé qu'une seule fois par séance
    CONSTRAINT UQ_SIEGE_SEANCE UNIQUE (numero_seance, Rangee_siege, Numero_siege)
);
