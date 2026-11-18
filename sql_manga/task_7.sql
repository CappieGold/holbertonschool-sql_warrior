SELECT factures.num_facture, SUM(prix_base * coefficient) AS depenses 
FROM factures 
JOIN table_location ON table_location.num_facture = factures.num_facture 
JOIN mangas ON mangas.num_manga = table_location.num_manga 
JOIN types_location ON types_location.code_type = table_location.code_type 
GROUP BY factures.num_facture 
ORDER BY num_facture;
