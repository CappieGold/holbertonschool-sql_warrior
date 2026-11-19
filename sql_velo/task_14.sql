SELECT utilisateurs.id, utilisateurs.nom_complet
FROM utilisateurs
LEFT JOIN locations ON locations.utilisateur_id = utilisateurs.id
WHERE locations.id IS NULL;
