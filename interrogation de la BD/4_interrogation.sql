-- Films de genre Action ou Thriller, triés par durée décroissante
SELECT Titre, Genre, Duree
FROM FILM
WHERE Genre IN ('Action', 'Thriller')
ORDER BY Duree DESC;

-- Séances dont le prix est entre 12 et 14 euros, triées par date
SELECT numero_seance, Date_seance, Heure_debut, Prix_base
FROM SEANCE
WHERE Prix_base BETWEEN 12.00 AND 14.00
ORDER BY Date_seance, Heure_debut;

-- Types de projecteurs disponibles (valeurs uniques)
SELECT DISTINCT Type_projecteur
FROM SALLE;

-- Clients dont le nom commence par D ou R
SELECT id_client, Nom, Prenom, Email
FROM CLIENT
WHERE Nom LIKE 'D%' OR Nom LIKE 'R%'
ORDER BY Nom;

-- Films sortis entre 2010 et 2020, triés par date de sortie
SELECT Titre, Date_sortie, Genre
FROM FILM
WHERE Date_sortie BETWEEN '2010-01-01' AND '2020-12-31'
ORDER BY Date_sortie;

-- Employés projectionnistes, triés par date d'embauche
SELECT Nom, Prenom, Date_embauche
FROM EMPLOYE
WHERE Role = 'Projectionniste'
ORDER BY Date_embauche ASC;

-- Nombre de séances programmées par salle
SELECT numero_salle, COUNT(*) AS nb_seances
FROM SEANCE
GROUP BY numero_salle
ORDER BY nb_seances DESC;

-- Recette totale et nombre de billets vendus par séance
SELECT S.numero_seance, S.Date_seance, COUNT(B.numero_billet) AS nb_billets,
       SUM(S.Prix_base) AS recette_totale
FROM SEANCE S
JOIN BILLET B ON S.numero_seance = B.numero_seance
GROUP BY S.numero_seance, S.Date_seance
ORDER BY recette_totale DESC;

-- Nombre de clients fidèles par tranche de points, avec moyenne par tranche
SELECT
    CASE
        WHEN Points_fidelite BETWEEN 100 AND 199 THEN '100-199'
        WHEN Points_fidelite BETWEEN 200 AND 299 THEN '200-299'
        ELSE '300 et plus'
    END AS tranche_points,
    COUNT(*) AS nombre_clients,
    AVG(Points_fidelite) AS moyenne_points
FROM CLIENT
WHERE Points_fidelite >= 100
GROUP BY
    CASE
        WHEN Points_fidelite BETWEEN 100 AND 199 THEN '100-199'
        WHEN Points_fidelite BETWEEN 200 AND 299 THEN '200-299'
        ELSE '300 et plus'
    END
HAVING COUNT(*) >= 1
ORDER BY moyenne_points DESC;

-- Nombre de billets vendus par moyen de paiement
SELECT Moyen_paiement, COUNT(*) AS nb_billets
FROM BILLET
GROUP BY Moyen_paiement
ORDER BY nb_billets DESC;

-- Films ayant eu plus d'une séance avec le nombre total de séances
SELECT F.Titre, COUNT(S.numero_seance) AS nb_seances
FROM FILM F
JOIN SEANCE S ON F.id_film = S.id_film
GROUP BY F.id_film, F.Titre
HAVING COUNT(S.numero_seance) > 1
ORDER BY nb_seances DESC;

-- Prix moyen, minimum et maximum des séances par salle
SELECT numero_salle,
       ROUND(AVG(Prix_base), 2) AS prix_moyen,
       MIN(Prix_base) AS prix_min,
       MAX(Prix_base) AS prix_max
FROM SEANCE
GROUP BY numero_salle
ORDER BY numero_salle;

-- Titre du film associé à chaque séance
SELECT S.numero_seance, S.Date_seance, S.Heure_debut, F.Titre, S.Prix_base
FROM SEANCE S
JOIN FILM F ON S.id_film = F.id_film
ORDER BY S.Date_seance;

-- Détail complet de chaque billet : client, film, salle, siège, paiement
SELECT B.numero_billet, C.Nom, C.Prenom, F.Titre, SA.numero_salle,
       SE.Date_seance, SE.Heure_debut, B.Rangee_siege, B.Numero_siege, B.Moyen_paiement
FROM BILLET B
JOIN CLIENT C ON B.id_client = C.id_client
JOIN SEANCE SE ON B.numero_seance = SE.numero_seance
JOIN FILM F ON SE.id_film = F.id_film
JOIN SALLE SA ON SE.numero_salle = SA.numero_salle
ORDER BY SE.Date_seance;

-- Films sans aucune séance programmée
SELECT F.id_film, F.Titre
FROM FILM F
LEFT JOIN SEANCE S ON F.id_film = S.id_film
WHERE S.numero_seance IS NULL;

-- Tous les employés avec leurs séances, y compris ceux sans séance assignée
SELECT E.Nom, E.Prenom, E.Role, S.numero_seance, S.Date_seance
FROM EMPLOYE E
LEFT JOIN SEANCE S ON E.id_employe = S.id_employe
ORDER BY E.Nom;

-- Films et leur suite directe (jointure récursive)
SELECT F1.Titre AS film_original, F2.Titre AS suite
FROM FILM F1
JOIN FILM F2 ON F2.id_film_precedent = F1.id_film;

-- Séances avec le nom de l'employé projectionniste et le film projeté
SELECT SE.numero_seance, SE.Date_seance, F.Titre,
       E.Nom AS employe_nom, E.Prenom AS employe_prenom, E.Role
FROM SEANCE SE
JOIN FILM F ON SE.id_film = F.id_film
JOIN EMPLOYE E ON SE.id_employe = E.id_employe
ORDER BY SE.Date_seance;

-- Clients ayant acheté au moins un billet
SELECT Nom, Prenom, Email
FROM CLIENT
WHERE id_client IN (
    SELECT DISTINCT id_client FROM BILLET
);

-- Clients n'ayant jamais acheté de billet
SELECT Nom, Prenom, Email
FROM CLIENT
WHERE id_client NOT IN (
    SELECT DISTINCT id_client FROM BILLET
);

-- Films pour lesquels au moins une séance a été programmée
SELECT Titre, Genre
FROM FILM F
WHERE EXISTS (
    SELECT 1 FROM SEANCE S WHERE S.id_film = F.id_film
);

-- Salles sans aucune séance planifiée
SELECT numero_salle, Capacite, Type_projecteur
FROM SALLE SA
WHERE NOT EXISTS (
    SELECT 1 FROM SEANCE S WHERE S.numero_salle = SA.numero_salle
);

-- Séances dont le prix est supérieur à au moins une séance de la salle 5
SELECT numero_seance, Prix_base, numero_salle
FROM SEANCE
WHERE Prix_base > ANY (
    SELECT Prix_base FROM SEANCE WHERE numero_salle = 5
);

-- Clients dont les points de fidélité dépassent tous les clients ayant payé en espèces
SELECT Nom, Prenom, Points_fidelite
FROM CLIENT
WHERE Points_fidelite > ALL (
    SELECT C.Points_fidelite
    FROM CLIENT C
    JOIN BILLET B ON C.id_client = B.id_client
    WHERE B.Moyen_paiement = 'Espèces'
);
