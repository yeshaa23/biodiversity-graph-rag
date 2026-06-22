// File ini berisi query-query Cypher yang digunakan untuk mengambil context dari Neo4j sebelum dikirim ke LLM
// Context ini dipakai agar jawaban GraphRAG tetap berdasarkan data graph biodiversity yang tersimpan di Neo4j

// negara dengan jumlah occurrence terbanyak
MATCH (o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN
c.name AS negara,
count(o) AS total_occurrence
ORDER BY total_occurrence DESC
LIMIT 10;

// tahun dengan jumlah occurrence terbanyak
MATCH (o:Occurrence)-[:RECORDED_IN_YEAR]->(y:Year)
RETURN
y.value AS tahun,
count(o) AS total_occurrence
ORDER BY total_occurrence DESC
LIMIT 10;

// species yang paling sering muncul dalam data occurrence
MATCH (o:Occurrence)-[:OBSERVED_SPECIES]->(s:Species)
RETURN
s.name AS species,
count(o) AS total_occurrence
ORDER BY total_occurrence DESC
LIMIT 10;

// context hasil pagerank untuk node country
// digunakan untuk melihat negara yang paling sentral berdasarkan hubungan occurrence dalam graph.
MATCH (c:Country)
WHERE c.pagerankScore IS NOT NULL
RETURN
c.name AS negara,
round(c.pagerankScore, 5) AS skor_pagerank
ORDER BY skor_pagerank DESC
LIMIT 10;

// context hasil pagerank untuk node year
// digunakan untuk melihat tahun yang paling sentral berdasarkan hubungan occurrence dalam graph.
MATCH (y:Year)
WHERE y.pagerankScore IS NOT NULL
RETURN
y.value AS tahun,
round(y.pagerankScore, 5) AS skor_pagerank
ORDER BY skor_pagerank DESC
LIMIT 10;

// context similarity antar species
// query ini mengambil pasangan species dengan nilai jaccard similarity tertinggi.
MATCH (s1:Species)-[r:SIMILAR_TO_JACCARD]->(s2:Species)
RETURN
s1.name AS species_1,
s2.name AS species_2,
round(r.jaccardScore, 4) AS skor_jaccard
ORDER BY skor_jaccard DESC
LIMIT 10;

// context hasil clustering K-Means
// query ini mengambil ringkasan cluster species, termasuk jumlah species, family dominan, negara dominan, dan contoh species.
MATCH (s:Species)
WHERE s.mlCluster IS NOT NULL
OPTIONAL MATCH (s)-[:BELONGS_TO]->(:Genus)-[:BELONGS_TO]->(f:Family)
OPTIONAL MATCH (s)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN
s.mlCluster AS cluster,
count(DISTINCT s) AS total_species,
collect(DISTINCT f.name)[0..10] AS family_dominan,
collect(DISTINCT c.name)[0..6] AS negara_dominan,
collect(DISTINCT s.name)[0..10] AS contoh_species
ORDER BY total_species DESC;

// context hasil LLM Graph Builder
// query ini mengambil hasil ekstraksi LLM dari species description, berupa habitat, threat, dan environment.
MATCH (s:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->(n)
RETURN
s.name AS species,
type(r) AS relasi,
labels(n)[0] AS tipe_node_hasil_ekstraksi,
n.name AS nama_hasil_ekstraksi
ORDER BY species, relasi
LIMIT 50;

// jumlah node hasil LLM Graph Builder
// cek jumlah node Habitat, threat, dan environment yang berhasil dibuat
MATCH (n)
WHERE n:Habitat OR n:Threat OR n:Environment
RETURN
labels(n)[0] AS tipe_node,
count(n) AS total_node
ORDER BY total_node DESC;

// jumlah relationship hasil LLM Graph Builder
MATCH (:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->()
RETURN
type(r) AS tipe_relasi,
count(r) AS total_relasi
ORDER BY total_relasi DESC;

// visualisasi hasil LLM Graph Builder
MATCH path = (s:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->(n)
RETURN path
LIMIT 200;
