// projection graph ml
CALL gds.graph.project(
  'speciesMLGraph',
  'Species',
  { SIMILAR_TO_JACCARD: {
      orientation: 'UNDIRECTED',
      properties: 'jaccardScore'}
  }
)
YIELD graphName, nodeCount, relationshipCount
RETURN
  graphName AS graph_name,
  nodeCount AS node_count,
  relationshipCount AS relationship_count;

// fastRP embedding 
CALL gds.fastRP.write('speciesMLGraph', {
  embeddingDimension: 8,
  writeProperty: 'fastrp_embedding',
  relationshipWeightProperty: 'jaccardScore',
  iterationWeights: [0.5, 0.75, 1.0],
  randomSeed: 42
})
YIELD nodePropertiesWritten
RETURN nodePropertiesWritten;

// cek hasil fastRP embedding
MATCH (s:Species)
WHERE s.fastrp_embedding IS NOT NULL
OPTIONAL MATCH (s)-[:BELONGS_TO]->(:Genus)-[:BELONGS_TO]->(f:Family)
OPTIONAL MATCH (s)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN
  s.name AS species,
  f.name AS family,
  collect(DISTINCT c.name)[0..3] AS countries,
  s.fastrp_embedding AS fastrp_embedding
LIMIT 10;

// cek cosine similarity hasil embedding 
MATCH (s1:Species)-[r:SIMILAR_TO_JACCARD]->(s2:Species)
WHERE s1.fastrp_embedding IS NOT NULL
  AND s2.fastrp_embedding IS NOT NULL
WITH s1, s2, r
ORDER BY r.jaccardScore DESC
LIMIT 15
RETURN
  s1.name AS species_1,
  s2.name AS species_2,
  round(r.jaccardScore, 4) AS jaccard_score,
  round(gds.similarity.cosine(s1.fastrp_embedding, s2.fastrp_embedding), 4) AS cosine_similarity;

// recreate projection dengan node property embedding 
// hapus projection awal
CALL gds.graph.drop('speciesMLGraph', false) YIELD graphName
RETURN graphName;

// projection
CALL gds.graph.project(
  'speciesMLGraph',
  'Species',
  { SIMILAR_TO_JACCARD: {
      orientation: 'UNDIRECTED',
      properties: 'jaccardScore'}},
  { nodeProperties: ['fastrp_embedding']}
)
YIELD graphName, nodeCount, relationshipCount
RETURN graphName, nodeCount, relationshipCount;

// knn similarity 
CALL gds.knn.stream('speciesMLGraph', {
  topK: 5,
  nodeProperties: ['fastrp_embedding'],
  randomSeed: 1337,
  concurrency: 1,
  sampleRate: 1.0})
YIELD node1, node2, similarity
WITH
  gds.util.asNode(node1) AS s1,
  gds.util.asNode(node2) AS s2,
  round(similarity * 1000) / 1000 AS knn_score
RETURN
  s1.name AS species_1,
  s2.name AS species_2,
  knn_score
ORDER BY knn_score DESC, species_1, species_2
LIMIT 20;

// kmeans clustering
CALL gds.kmeans.write('speciesMLGraph', {
  nodeProperty: 'fastrp_embedding',
  k: 3,
  randomSeed: 99,
  writeProperty: 'mlCluster'
})
YIELD nodePropertiesWritten, communityDistribution
RETURN nodePropertiesWritten, communityDistribution;

// kmeans species sample
MATCH (s:Species)
WHERE s.mlCluster IS NOT NULL
RETURN
  s.mlCluster AS cluster,
  collect(s.name)[0..15] AS species_members,
  count(s) AS total_species
ORDER BY total_species DESC;
