DROP TABLE IF EXISTS BILLET;
DROP TABLE IF EXISTS SEANCE;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS EMPLOYE;
DROP TABLE IF EXISTS SALLE;
DROP TABLE IF EXISTS FILM;


CREATE TABLE FILM (
    id_film             VARCHAR(10)  NOT NULL,
    Titre               VARCHAR(100) NOT NULL,
    Duree               INT          NOT NULL,       
    Genre               VARCHAR(30)  NOT NULL,
    Date_sortie         DATE         NOT NULL,
    Synopsis            VARCHAR(500),
    id_film_precedent   VARCHAR(10)  DEFAULT NULL,   

    CONSTRAINT PK_FILM PRIMARY KEY (id_film),

    CONSTRAINT UQ_FILM_PRECEDENT UNIQUE (id_film_precedent),

    CONSTRAINT FK_FILM_SUITE FOREIGN KEY (id_film_precedent)
        REFERENCES FILM(id_film)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);



CREATE TABLE SALLE (
    numero_salle    INT         NOT NULL,
    Capacite        INT         NOT NULL,    
    Type_projecteur VARCHAR(20) NOT NULL,    

    CONSTRAINT PK_SALLE PRIMARY KEY (numero_salle)
);



CREATE TABLE EMPLOYE (
    id_employe    VARCHAR(10) NOT NULL,
    Nom           VARCHAR(50) NOT NULL,
    Prenom        VARCHAR(50) NOT NULL,
    Role          VARCHAR(30) NOT NULL,
    Date_embauche DATE        NOT NULL,

    CONSTRAINT PK_EMPLOYE PRIMARY KEY (id_employe)
);



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



CREATE TABLE SEANCE (
    numero_seance VARCHAR(10)  NOT NULL,
    Date_seance   DATE         NOT NULL,
    Heure_debut   TIME         NOT NULL,
    Prix_base     DECIMAL(5,2) NOT NULL,
    numero_salle  INT          NOT NULL,
    id_employe    VARCHAR(10)  NOT NULL,
    id_film       VARCHAR(10)  NOT NULL,

    CONSTRAINT PK_SEANCE PRIMARY KEY (numero_seance),

    CONSTRAINT FK_SEANCE_SALLE FOREIGN KEY (numero_salle)
        REFERENCES SALLE(numero_salle)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_SEANCE_EMPLOYE FOREIGN KEY (id_employe)
        REFERENCES EMPLOYE(id_employe)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_SEANCE_FILM FOREIGN KEY (id_film)
        REFERENCES FILM(id_film)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



CREATE TABLE BILLET (
    numero_billet  VARCHAR(12) NOT NULL,
    Date_achat     DATE        NOT NULL,
    Rangee_siege   VARCHAR(2)  NOT NULL,
    Numero_siege   INT         NOT NULL,
    Moyen_paiement VARCHAR(20) NOT NULL,
    id_client      VARCHAR(10) NOT NULL,
    numero_seance  VARCHAR(10) NOT NULL,

    CONSTRAINT PK_BILLET PRIMARY KEY (numero_billet),

    CONSTRAINT FK_BILLET_CLIENT FOREIGN KEY (id_client)
        REFERENCES CLIENT(id_client)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_BILLET_SEANCE FOREIGN KEY (numero_seance)
        REFERENCES SEANCE(numero_seance)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT UQ_SIEGE_SEANCE UNIQUE (numero_seance, Rangee_siege, Numero_siege)
);
