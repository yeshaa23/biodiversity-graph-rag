// buat feature relationships untuk similarity species 
// species connect ke country 
MATCH (s:Species)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN]->(c:Country)
MERGE (s)-[:SIM_COUNTRY]->(c);

// species connect ke family
MATCH (s:Species)-[:BELONGS_TO]->(:Genus)-[:BELONGS_TO]->(f:Family)
MERGE (s)-[:SIM_FAMILY]->(f);

// projection similarity 
CALL gds.graph.project(
  'speciesSimilarityGraph',
  ['Species', 'Country', 'Family'],
  { SIM_COUNTRY: {
      orientation: 'NATURAL'},
    SIM_FAMILY: {
      orientation: 'NATURAL'}
  }
)
YIELD graphName, nodeCount, relationshipCount
RETURN graphName, nodeCount, relationshipCount;

// jaccard node similarity 
CALL gds.nodeSimilarity.write('speciesSimilarityGraph', {
  similarityMetric: 'JACCARD',
  topK: 5,
  similarityCutoff: 0.2,
  writeRelationshipType: 'SIMILAR_TO_JACCARD',
  writeProperty: 'jaccardScore'
})
YIELD nodesCompared, relationshipsWritten, similarityDistribution
RETURN nodesCompared, relationshipsWritten, similarityDistribution;

// top species similarity 
MATCH (s1:Species)-[r:SIMILAR_TO_JACCARD]->(s2:Species)
RETURN
  s1.name AS species_1,
  s2.name AS species_2,
  round(r.jaccardScore, 4) AS jaccard_score
ORDER BY jaccard_score DESC
LIMIT 20;

// distribusi nilai hasil similarity 
MATCH (s1:Species)-[r:SIMILAR_TO_JACCARD]->(s2:Species)
WITH round(r.jaccardScore, 3) AS similarity
RETURN similarity, count(*) AS total_pairs
ORDER BY similarity DESC;

// projection untuk centrality dan community detection 
CALL gds.graph.project(
  'biodiversityGraph',
  ['Occurrence','Species','Genus','Family','Order','Class','Phylum','Kingdom','Country','Year'],
  { OBSERVED_SPECIES: {
      orientation: 'UNDIRECTED'},
    RECORDED_IN: {
      orientation: 'UNDIRECTED'},
    RECORDED_IN_YEAR: {
      orientation: 'UNDIRECTED'},
    BELONGS_TO: {
      orientation: 'UNDIRECTED'}}
)
YIELD graphName, nodeCount, relationshipCount
RETURN graphName, nodeCount, relationshipCount;

// cek projection 
CALL gds.graph.list('biodiversityGraph')
YIELD graphName, nodeCount, relationshipCount
RETURN graphName, nodeCount, relationshipCount;

// pagerank centrality
CALL gds.pageRank.write('biodiversityGraph', {
  writeProperty: 'pagerankScore'
})
YIELD nodePropertiesWritten, ranIterations
RETURN nodePropertiesWritten, ranIterations;

// hasil pagerank centrality country 
MATCH (c:Country)
WHERE c.pagerankScore IS NOT NULL
RETURN
  c.name AS country,
  round(c.pagerankScore, 5) AS pagerank_score
ORDER BY pagerank_score DESC;

// hasil pagerank centrality year  
MATCH (y:Year)
WHERE y.pagerankScore IS NOT NULL
RETURN
  y.value AS year,
  round(y.pagerankScore, 5) AS pagerank_score
ORDER BY pagerank_score DESC;

// louvain community detection 
CALL gds.louvain.write('biodiversityGraph', {
  writeProperty: 'communityId'
})
YIELD communityCount, modularity, nodePropertiesWritten
RETURN communityCount, modularity, nodePropertiesWritten;

// preview species community 
MATCH (s:Species)
WHERE s.communityId IS NOT NULL
RETURN
  s.communityId AS community_id,
  count(s) AS total_species,
  collect(s.name)[0..15] AS sample_species
ORDER BY total_species DESC
LIMIT 10;

// visualisasi community terbesar 
MATCH (n)
WHERE n.communityId IS NOT NULL
WITH n.communityId AS communityId, count(n) AS total_nodes
ORDER BY total_nodes DESC
LIMIT 1
MATCH path = (a)-[r]-(b)
WHERE a.communityId = communityId
  AND b.communityId = communityId
RETURN path
LIMIT 150;

//lihat year dominan per komunitas 
MATCH (s:Species)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN_YEAR]->(y:Year)
WHERE s.communityId IS NOT NULL
WITH s.communityId AS communityId, y.value AS year, count(o) AS freq
ORDER BY communityId, freq DESC
RETURN
  communityId,
  collect({year: year, count: freq})[0..5] AS topYears
LIMIT 10;

// lihat country dominan per komunitas
MATCH (s:Species)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN]->(c:Country)
WHERE s.communityId IS NOT NULL
WITH s.communityId AS communityId, c.name AS country, count(o) AS freq
ORDER BY communityId, freq DESC
RETURN
  communityId,
  collect({country: country, count: freq})[0..5] AS topCountries
LIMIT 10;
