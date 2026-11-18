SELECT clients.code_client, prenom, nom, COUNT(*) AS nombre_de_location, ROUND(SUM(prix_base * coefficient), 2) AS total_depenses
FROM clients 
JOIN factures ON factures.code_client = clients.code_client 
JOIN table_location ON table_location.num_facture = factures.num_facture
JOIN types_location ON types_location.code_type = table_location.code_type 
JOIN mangas ON mangas.num_manga = table_location.num_manga 
GROUP BY clients.code_client 
ORDER BY total_depenses DESC
LIMIT 5;
