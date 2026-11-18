SELECT ville,
SUM(CASE WHEN signification = 'Aventure' THEN 1 ELSE 0 END) AS Aventure,
SUM(CASE WHEN signification = 'Fantasy' THEN 1 ELSE 0 END) AS Fantasy,
SUM(CASE WHEN signification = 'Horreur' THEN 1 ELSE 0 END) AS Horreur,
SUM(CASE WHEN signification = 'Shōnen' THEN 1 ELSE 0 END) AS Shōnen
From clients
JOIN factures ON factures.code_client = clients.code_client
JOIN table_location ON table_location.num_facture = factures.num_facture
JOIN mangas ON mangas.num_manga = table_location.num_manga
JOIN genres_manga ON genres_manga.code_genre = mangas.code_genre
GROUP BY ville
ORDER BY ville;
