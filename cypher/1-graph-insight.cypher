// Database check 
// cek total nodes per label 
MATCH (n)
RETURN labels(n) AS label, count(n) AS total
ORDER BY total DESC;

// cek total relationships
MATCH ()-[r]->()
RETURN type(r) AS relationship, count(r) AS total
ORDER BY total DESC;

// cek sample occurence species 
MATCH path = (o:Occurrence)-[:OBSERVED_SPECIES]->(:Species)
RETURN path
LIMIT 25;

// cek sample occurence country
MATCH path = (o:Occurrence)-[:RECORDED_IN]->(:Country)
RETURN path
LIMIT 25;

// cek sample occurence year
MATCH path = (o:Occurrence)-[:RECORDED_IN_YEAR]->(:Year)
RETURN path
LIMIT 25;

// negara dengan occurence terbanyak 
MATCH (o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN c.name AS country, count(o) AS total_occurrences
ORDER BY total_occurrences DESC;

// tahun dengan occurance terbanyak 
MATCH (o:Occurrence)-[:RECORDED_IN_YEAR]->(y:Year)
RETURN y.value AS year, count(o) AS total_occurrences
ORDER BY year;

// species paling dominan (sering muncul) 
MATCH (o:Occurrence)-[:OBSERVED_SPECIES]->(s:Species)
RETURN s.name AS species, count(o) AS total_occurrences
ORDER BY total_occurrences DESC
LIMIT 10;

// family dengan species terbanyak 
MATCH (s:Species)-[:BELONGS_TO]->(:Genus)-[:BELONGS_TO]->(f:Family)
RETURN f.name AS family, count(DISTINCT s) AS total_species
ORDER BY total_species DESC
LIMIT 10;
