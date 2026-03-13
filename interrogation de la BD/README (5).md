# Projet SDD : Gestion Cinématographique

## V. Scénario d'utilisation — Interrogation de la base de données

**Rôle : Sarah Lemaire, Responsable de programmation**

Sarah Lemaire est la responsable de programmation du complexe cinématographique. Chaque début de mois, elle consulte la base de données pour préparer le bilan d'activité du mois écoulé et orienter les décisions de programmation pour le mois suivant.

Elle a besoin d'extraire les données suivantes :

- La liste des films programmés par genre et durée, pour évaluer la diversité de l'offre
- Les séances organisées par salle avec leurs horaires, prix et volumes de vente, pour analyser la programmation et l'utilisation des salles
- Le nombre de billets vendus par séance et les recettes générées, pour identifier les films les plus rentables
- Les moyens de paiement utilisés, pour adapter les options proposées en caisse
- Les clients fidèles avec leurs points accumulés, pour cibler les offres promotionnelles
- Les films qui sont des suites, pour anticiper les attentes du public
- Les employés affectés aux séances, pour optimiser la gestion des plannings
- Les salles sans séance planifiée, pour éviter les équipements inutilisés

Les requêtes SQL correspondantes sont disponibles dans le fichier `4_interrogation.sql`.
