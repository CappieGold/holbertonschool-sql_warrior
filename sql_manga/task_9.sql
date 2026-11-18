SELECT titre, prenom, nom, pays
FROM mangas JOIN mangakas ON mangakas.code_mangaka = mangas.code_mangaka
ORDER BY titre;
