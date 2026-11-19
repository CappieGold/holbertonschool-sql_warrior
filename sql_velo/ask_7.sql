SELECT locations.id, nom_complet, code, date_debut, date_fin, montant
FROM locations
JOIN utilisateurs ON utilisateurs.id = locations.utilisateur_id
JOIN velos ON velos.id = locations.velo_id
JOIN paiements ON paiements.location_id = locations.id
WHERE locations.id = 1;
