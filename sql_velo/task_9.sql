SELECT code, COUNT(date_debut) AS nombre_de_location
FROM velos
JOIN locations ON locations.velo_id = velos.id
GROUP BY code
ORDER BY code;
