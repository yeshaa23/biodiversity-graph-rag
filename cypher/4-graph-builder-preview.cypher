// Habitat, Threat, and Environment extraction
// cek node hasil graph builder 
MATCH (n)
WHERE n:Habitat OR n:Threat OR n:Environment
RETURN
  labels(n)[0] AS label,
  count(n) AS total
ORDER BY total DESC;

// cek relationship hasil graph builder 
MATCH (:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->()
RETURN
  type(r) AS relationship,
  count(r) AS total
ORDER BY total DESC;

// Preview hasil ekstraksi graph builder 
MATCH (s:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->(n)
RETURN
  s.name AS species,
  type(r) AS relationship,
  labels(n)[0] AS target_label,
  n.name AS target_name
ORDER BY species, relationship
LIMIT 50;

// cek apakah semua species hasil graph memiliki hasil ekstraksi 
MATCH (s:Species)
WHERE (s)-[:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->()
RETURN
  count(DISTINCT s) AS species_with_extraction;

// visualisasi hasil graph builder 
MATCH path = (s:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->(n)
RETURN path
LIMIT 200;
