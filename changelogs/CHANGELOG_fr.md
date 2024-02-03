# **v2.5.2** :

- *Fix*:
  - Les notifications sont maintenant affichées correctement (vraiement).
***
# **v2.5.1** :

- *Fix*:
  - Les notifications sont maintenant affichées correctement.
***
# **v2.5.0** :

- *Dev*:
  - Mise à jour de Flutter
  - Mise à jour des dépendances
- *UI*:
  - Un message est maintenant affiché pour signaler qu'il n'y a plus de fermeture du pont de prévu
***
# **v2.4.2** :

- *Fix*:
  - Correction d'un bug qui faisait planter l'affichage de la page "A propos" en mode paysage
***
# **v2.4.1** :

- *Fix*:
  - Correction d'un bug qui n'affichait pas le bon formattage des heures dans les notifications
  - Correction d'un bug qui empêchait la fenêtre des réglages de correctement s'afficher en mode paysage
- *UI*:
  - La fenêtre "A propos" à maintenant un mode paysage
***
# **v2.4.0** :

- L'utilisateur peut désormais choisir le format horaire des heures affichées
- Mise à niveau vers Flutter 3.13.3
- Mise à niveau des bibliothèques
***
# **v2.3.1** :

- Corrections de bugs et améliorations des performances
***
# **v2.3.0** :

- Refonte de la page 'A propos'
***
# **v2.2.0** :

- Corrections de bugs et améliorations des performances
***
# **v2.1.0** :

- *Fonctionnalités*:
  - Prise en charge de la Fête du Vin
  - Changement de la page WEB affichant les informations des navires
- *Fix*:
  - Correction de bugs divers
- *Interface*:
  - Nouvelle icône pour les passages de navires
  - Améliorations pour une meilleure lisibilité
***
# **v2.0.0** :

- *Fix*:
  - La détection des évènements multi bateaux fonctionne maintenant correctement
  - Les évènements sur deux jours sont maintenant correctement détectés
- *Interface*:
  - L'affichage des évènements a été complètement revu
  - Il est maintenant affiché les bateaux actuellement amarrés au Port de la Lune
***
# **v1.9.2** :

- *Fix*:
  - Les notifications se ferment maintenant automatiquement sur écran vérouilé
- *Fonctionnalités*:
  - Modification du texte des notifications pour les rendre plus riches en informations
  - Les notifications demandant une heure à l'utilisateur peuvent être modifiées directement via le clavier
***
# **v1.9.1** :

- *Fix*:
  - Annulation de la mise à jour de Gradle
***
# **v1.9.0** :

- *Fonctionnalités*:
  - Il est maintenant possible d'ajouter des jours de la semaine aux créneaux horaires
- *Interface*:
  - Corrections et ajout mineurs
- *Core*:
  - Mise à jour en Gradle 8
***
# **v1.8.1** :

- *Fix*:
  - Les créneaux horaires sur des évènements d'étalant sur deux jours fonctionnent maintenant normalement
- *Interface*:
  - Ajout du support pour les tablettes
***
# **v1.8.0** :

- *Fix*:
  - Certains créneux n'étaient pas pris bien pris en compte
- *Interface*:
  - Les fermetures passées ne sont plus affichées
  - La fenêtre principale est plus organique
  - Ajout d'un bouton permettant d'aller directement vérifier les créneaux configurés
- *Core*:
  - Mise à jour en Flutter 3.10.0
***
# **v1.6.1** :

- *Fix*:
  - La SnackBar d'avertissement de l'activation des notifications sur les créneaux est maintenant correctement en place
- *Interface*:
  - Ajout d'un padding pour afficher le dernier élément de la liste des fermetures
  - Seulement une seule publicité est maintenant affichée
***
# **v1.6.0** :

- *Fonctionnalités*:
  - Il est maintenant possible d'ajouter deux créneaux favoris pour n'être averti que des évènements impactant
- *Interface*:
  - Remaniement de la liste des fermetures afin de la rendre plus facile à lire.
  - Mise en valeur d'événements impactants grâce à une bordure orange.
  - Ajout d'un message si les notifications sont désactivées
***
# **v1.4.0** :

- *Fonctionnalités*:
  - Il est maintenant possible de choisir l'heure à laquelle les notifications de recap de fin de semaine sont envoyées
***
# **v1.3.2** :

- *Google play store*:
  - Mise en conformité de la description
***
# **v1.3.1** :

- *Fix*:
  - La notification de recap fonctionne maintenant correctement
  - La couleur du status est correctement affichée au démarrage de l'application
***
# **v1.3.0** :

- *Fix*:
  - L'icône de l'application s'affiche maintenant correctement sur les notifications
  - L'icône de l'application s'affiche maintenant sur fond blanc dans la fenêtre "Licenses"
- *Interface*:
  - Disparition de la fenêtre des réglages au profit d'un bouton flotant
  - L'interface se met maintenant à jour en temps réel
  - Ajout de nouvelles transitions / animations
- *Fonctionnalités*:
  - Utilisable par des gaucher.ères
***
# **v1.1.0** :

- *Fix*:
  - La première fermeture s'affiche maintenant correctement 
- *Interface*:
  - Retravail de la fenêtre "A propos"
  - Retravail complet de la fenêtre de gestion des notifications
  - Quelques améliorations pour la lisibilité
- *Fonctionnalités*:
  - Les notifications de recap sont maintenant fonctionnelles
***
# **v1.0.0** :
Première version stable
- *Fonctionnalités*:
  - Ajout du support de la modification de la langue
***
# **v0.12.0** :

- *Fonctionnalités*:
  - Ajout du support de la langue espagnole
***
# **v0.11.5** :

- *Fonctionnalités*:
  - Quelques améliorations pour l'interface utilisateur
  - Ajout de la prise en charge de l'icône thématique sur Android
***
# **v0.11.0** :

- *Fonctionnalités*:
  - Mise en place des publicités
  - Ajout des notifications de fermeture et d'ouverture du pont
***
# **v0.10.0** :

- *UI* :
  - L'écran principal est maintenant plus réactif
  - Afficher les dernières fermetures avec une carte floue
  - Les prévisions de bateaux gèrent désormais les événements multi-bateaux
***
# **v0.9.0** :

- *UI* :
  - Refonte des tuiles principales
  - Ajout des emoji dans les notifications
- *Dév* :
  - Utilisez Cubit pour gérer le NotificationService
- *Play store* :
  - Ajouter une page Playstore en GB
***
# **v0.8.0** :

- *Fonctionnalités*:
  - La notification de l'heure fonctionne maintenant. Toujours en cours
***
# **v0.7.0** :

- *Fonctionnalités*:
  - Les notifications de durée fonctionnent maintenant. Toujours en cours
***
# **v0.6.5** :

- *Fix*:
  - Corrigez les vibrations qui ont été déclenchées par le mauvais événement
- *Caractéristiques*:
  - Les paramètres de notification sont désormais persistants lors du redémarrage de l'application
***
# **v0.6.0** :

- *Réparer*:
  - Le thème n'a pas été mis à jour lorsque l'application a repris
  - Correction de la mauvaise URL Github
- *UI* :
  - Ajout d'un dialogue pour les notifications (WIP)
  - Ajustements mineurs
- *Play store* :
  - Ajout d'une page Playstore en-US
***
# **v0.5.0** :

- *Fonctionnalitées*:
  - On peut maintenant choisir entre un thème clair ou sombre
  - Affichage des informations de l'application
- *Fix*:
  - Les propriétés finales définies deux fois ont fait planter l'application
- *UI* :
  - Toute nouvelle identité visuelle
  - Utilisation du Material 3

***
# **v0.0.1** :

- Version initiale à des fins de test
***
