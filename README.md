Projet SDD : Gestion Cinématographique
Ce dépôt contient le travail d'analyse et de modélisation pour un complexe de cinémas (type Pathé/UGC).

I. Analyse des besoins (Étape 1)
I.A. Le Prompt utilisé (Framework RICARDO)
Conformément aux consignes, voici le prompt final complété qui a servi à interroger l'IA :

Rôle : Tu travailles dans le domaine du cinéma et du divertissement.
Contexte : Ton organisation a comme activité de gérer la programmation des films, la diffusion des séances en salle et la vente de billets. C’est une organisation comme Pathé ou UGC.
Références : Les données ont été collectées sur les films (titres, durées, suites), les salles de projection (capacités), les séances (horaires), les employés (projectionnistes et accueil), les clients fidélisés et les réservations de places. Inspire-toi du site web suivant : https://www.allocine.fr.
Instructions : Ton organisation veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse. Établis les règles de gestions des données sous la forme d'une liste à puce. Ensuite, fournis un dictionnaire de données brutes (entre 25 et 35 données) dans un tableau (signification, type, taille).
Rendement : Fournis les règles de gestion et le dictionnaire de données.

I.B. Règles de gestion obtenues
Chaque film est identifié par un titre unique et possède une durée, un genre et une date de sortie.

Un film peut être la suite d'un autre film (relation récursive).

Le cinéma dispose de plusieurs salles avec une capacité précise.

Une séance concerne un seul film dans une seule salle à une heure précise.

Une projection (séance) nécessite la présence d'un employé technique (projectionniste).

Les clients peuvent s'inscrire au programme de fidélité avec leur nom, prénom et email.

Un client peut acheter plusieurs billets, chaque billet étant lié à une séance spécifique.

Les employés sont définis par leur nom, leur rôle et leur date d'embauche.

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

<img width="1332" height="596" alt="image" src="https://github.com/user-attachments/assets/9cd70cac-bd9a-47cd-b238-310698ea2056" />

