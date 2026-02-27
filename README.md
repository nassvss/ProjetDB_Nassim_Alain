# Projet SDD : Gestion Cinématographique

Ce dépôt contient le travail d'analyse et de modélisation pour un complexe de cinémas (type Pathé/UGC).

---

## I. Analyse des besoins (Étape 1)

### I.A. Le Prompt utilisé (Framework RICARDO)

Conformément aux consignes, voici le prompt final complété qui a servi à interroger l'IA :

> **Rôle :** Tu travailles dans le domaine du cinéma et du divertissement.
>
> **Contexte :** Ton organisation a comme activité de gérer la programmation des films, la diffusion des séances en salle et la vente de billets. C'est une organisation comme Pathé ou UGC.
>
> **Références :** Les données ont été collectées sur les films (titres, durées, suites), les salles de projection (capacités), les séances (horaires), les employés (projectionnistes et accueil), les clients fidélisés et les réservations de places. Inspire-toi du site web suivant : https://www.allocine.fr.
>
> **Instructions :** Ton organisation veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse. Établis les règles de gestions des données sous la forme d'une liste à puce. Ensuite, fournis un dictionnaire de données brutes (entre 25 et 35 données) dans un tableau (signification, type, taille).
>
> **Rendement :** Fournis les règles de gestion et le dictionnaire de données.

---

### I.B. Règles de gestion obtenues

- Chaque film est identifié par un titre unique et possède une durée, un genre, un synopsis et une date de sortie nationale.
- Un film peut être la suite d'au plus un autre film, et un film peut avoir au plus une suite directe (relation récursive, cardinalités 0,1 — 0,1).
- Le cinéma dispose de plusieurs salles, chacune ayant une capacité précise (nombre de sièges) et un type de projecteur.
- Une séance concerne un seul film, dans une seule salle, à une date et heure précises, et possède un prix de base.
- Chaque séance est assurée par un employé (projectionniste) dans une salle donnée. Un employé peut assurer plusieurs séances, et une salle peut accueillir plusieurs séances.
- Les employés sont définis par leur nom, prénom, rôle/poste et date d'embauche.
- Les clients peuvent s'inscrire au programme de fidélité avec leur nom, prénom, email et date de naissance.
- Un client inscrit au programme de fidélité accumule des points à chaque achat de billet. Le nombre de points courants est enregistré dans son profil.
- Un client peut acheter plusieurs billets via différents moyens de paiement.
- Un billet est associé à une séance précise et correspond à un siège identifié par une rangée et un numéro de siège.

---

### I.C. Dictionnaire de données

| Signification de la donnée | Type | Taille |
| :--- | :--- | :--- |
| Identifiant du film | Alphanumérique | 10 |
| Titre du film | Texte | 100 |
| Durée du film (en minutes) | Numérique | 3 |
| Genre du film | Texte | 30 |
| Date de sortie nationale | Date | 10 |
| Synopsis du film | Texte | 500 |
| Identifiant du film précédent (pour les suites) | Alphanumérique | 10 |
| Numéro de la salle | Numérique | 2 |
| Capacité de la salle (nombre de sièges) | Numérique | 3 |
| Type de projecteur (Laser, Numérique, 3D) | Texte | 20 |
| Numéro de la séance | Numérique | 8 |
| Date de la séance | Date | 10 |
| Heure de début de la séance | Heure | 5 |
| Prix de base de la séance | Numérique | 5 |
| Identifiant de l'employé | Alphanumérique | 10 |
| Nom de l'employé | Texte | 50 |
| Prénom de l'employé | Texte | 50 |
| Rôle/Poste de l'employé | Texte | 30 |
| Date d'embauche de l'employé | Date | 10 |
| Identifiant du client | Alphanumérique | 10 |
| Nom du client | Texte | 50 |
| Prénom du client | Texte | 50 |
| Adresse email du client | Texte | 100 |
| Date de naissance du client | Date | 10 |
| Points de fidélité accumulés | Numérique | 6 |
| Numéro du billet | Numérique | 12 |
| Date d'achat du billet | Date | 10 |
| Rangée du siège réservé | Texte | 2 |
| Numéro du siège réservé | Numérique | 3 |
| Moyen de paiement utilisé | Texte | 20 |

---

## II. MCD (Étape 2)

### II.A. Choix de modélisation

Le MCD respecte la 3ème Forme Normale (3FN) et intègre les deux éléments de modélisation avancée suivants :

1. **Association récursive** : `EST LA SUITE DE` sur l'entité FILM (cardinalités 0,1 — 0,1), modélisant le fait qu'un film peut être la suite d'au plus un autre film, et qu'un film ne peut avoir qu'une seule suite directe.

2. **Association ternaire (n-aire avec n=3)** : `PROJETER` relie les entités EMPLOYÉ, SALLE et SÉANCE, modélisant le fait qu'une séance est projetée dans une salle précise par un employé précis.

### II.B. Schéma du MCD

![MCD Gestion Cinématographique](https://github.com/user-attachments/assets/9cd70cac-bd9a-47cd-b238-310698ea2056)

### II.C. Description des entités et associations

**Entités :**
- `FILM` (id_film, Titre, Durée, Genre, Synopsis, Date sortie)
- `SALLE` (numero_salle, Capacité, Type projecteur)
- `SÉANCE` (numero_seance, Date séance, Heure début, Prix base)
- `EMPLOYÉ` (id_employé, Nom, Prenom, Rôle, Date embauche)
- `CLIENT` (id_client, Nom, Prenom, Email, Date de naissance, Points fidélité)
- `BILLET` (numero_billet, Date achat billet, Rangee siege réservé, Numero siege réservé, Moyen paiement utilisé)

**Associations :**
- `EST LA SUITE DE` : récursive sur FILM (0,1 — 0,1)
- `CONCERNER` : FILM (0,n) — SÉANCE (1,1) — un film peut avoir plusieurs séances, une séance concerne exactement un film
- `PROJETER` : ternaire entre EMPLOYÉ (0,n), SALLE (0,n) et SÉANCE — une séance est assurée par un employé dans une salle
- `RESERVER` : SÉANCE (1,n) — BILLET (1,1) — une séance peut avoir plusieurs billets, un billet est lié à une séance
- `ACHETER` : CLIENT (0,n) — BILLET (1,1) — un client peut acheter plusieurs billets, un billet est acheté par un seul client
