SELECT mangas.titre, mangakas.prenom, mangakas.nom, signification 
FROM mangas 
JOIN table_location ON table_location.num_manga = mangas.num_manga
JOIN factures ON factures.num_facture = table_location.num_facture
JOIN clients ON clients.code_client = factures.code_client
JOIN genres_manga ON genres_manga.code_genre = mangas.code_genre
JOIN mangakas ON mangakas.code_mangaka = mangas.code_mangaka
WHERE signification = 'horreur';
