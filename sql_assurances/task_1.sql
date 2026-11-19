SELECT libelle, nbplaces, modele, couleur, immat
FROM types_vehicules
JOIN vehicules ON vehicules.type_voiture = types_vehicules.id;
