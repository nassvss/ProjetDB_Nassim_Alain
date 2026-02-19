Tu travailles dans le domaine du cinéma et du divertissement. Ton organisation a comme activité de gérer la programmation des films, la diffusion des séances en salle et la vente de billets.

C’est une organisation comme Pathé ou UGC. Les données ont été collectées sur les films (titres, durées, suites), les salles de projection (capacités), les séances (horaires), les employés (projectionnistes et accueil), les clients fidélisés et les réservations de places.

Inspire-toi du site web suivant : https://www.allocine.fr.

Ton organisation veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données.

D’abord, établis les règles de gestions des données de ton organisation, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information.

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.

Fournis donc les règles de gestion et le dictionnaire de données.

"Voici le résultat de l'**étape 1** (analyse des besoins) pour le domaine du **cinéma**, en suivant strictement la structure du prompt de référence que vous avez fourni.

### Analyse des besoins : Complexe Cinématographique

Tu travailles dans le domaine du **cinéma et du divertissement**. Ton **organisation** a comme activité de **gérer la diffusion de films, la programmation des séances et la vente de billets au public**. C’est une **organisation** comme **Pathé, UGC ou CGR**. Des données ont été collectées sur **les films à l'affiche, les salles de projection, les horaires de diffusion, le personnel technique et les clients possédant une carte de fidélité**. Inspire-toi du site web suivant : **allocine.fr**.

#### 1. Règles de gestion

Voici comment fonctionne notre complexe au quotidien:

* Chaque film est identifié par un titre unique et possède une durée précise ainsi qu'un genre (Action, Comédie, etc.).


* Un film peut avoir été réalisé après un autre film, comme une suite (par exemple : Avatar 2 est la suite d'Avatar 1).


* Le cinéma dispose de plusieurs salles, chacune ayant un numéro et une capacité maximale de places.


* Un film est projeté lors de plusieurs séances ; chaque séance a une date et une heure de début précise.


* Pour chaque séance, un seul film est diffusé dans une seule salle précise.


* Une projection nécessite la présence d'un employé (projectionniste) pour lancer le film dans la salle à l'heure prévue.


* Les clients peuvent s'inscrire au programme de fidélité en donnant leur nom, prénom et adresse email.


* Un client peut acheter plusieurs billets, mais chaque billet est valable pour une seule séance spécifique.


* Chaque employé a un nom, un rôle (technicien, accueil, manager) et une date d'embauche.



#### 2. Dictionnaire de données brutes

Ce tableau recense les 30 données principales nécessaires au système.

| Signification de la donnée | Type | Taille |
| --- | --- | --- |
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
