SELECT factures.num_facture, prenom, nom, mangas.titre, libelle, date_retour 
FROM factures JOIN clients ON clients.code_client = factures.code_client 
JOIN table_location ON table_location.num_facture = factures.num_facture 
JOIN types_location ON types_location.code_type = table_location.code_type 
JOIN mangas ON mangas.num_manga = table_location.num_manga;
