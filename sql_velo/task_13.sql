SELECT code, COUNT(date_debut) as total_locations
FROM velos
LEFT JOIN locations ON locations.velo_id = velos.id
GROUP BY code
ORDER BY total_locations DESC;
