# %%
# import library
import os
import pandas as pd
from dotenv import load_dotenv
from openai import OpenAI
from neo4j import GraphDatabase

# %%
# load config
load_dotenv()
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
MODEL_NAME = os.getenv("OPENROUTER_MODEL", "openai/gpt-oss-120b:free")
NEO4J_URI = os.getenv("NEO4J_URI", "neo4j://127.0.0.1:7687")
NEO4J_USER = os.getenv("NEO4J_USER", "neo4j")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD")
NEO4J_DATABASE = os.getenv("NEO4J_DATABASE", "neo4j")

print("MODEL:", MODEL_NAME)
print("NEO4J_URI:", NEO4J_URI)
if not OPENROUTER_API_KEY:
    raise ValueError("OPENROUTER_API_KEY belum diisi di file .env")
if not NEO4J_PASSWORD:
    raise ValueError("NEO4J_PASSWORD belum diisi di file .env")

# %%
# koneksi openrouter dan neo4j
llm_client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=OPENROUTER_API_KEY
)
driver = GraphDatabase.driver(
    NEO4J_URI,
    auth=(NEO4J_USER, NEO4J_PASSWORD)
)

driver.verify_connectivity()
print("Neo4j connection successful.")
print("OpenRouter connection ready.")

# %%
# fungsi menjalankan cypher 
def run_cypher(query):
    with driver.session(database=NEO4J_DATABASE) as session:
        result = session.run(query)
        records = [record.data() for record in result]
    return pd.DataFrame(records)

# %%
# cek database
run_cypher("""
MATCH (n)
RETURN labels(n)[0] AS label, count(n) AS total
ORDER BY total DESC
""")

# %%
# fungsi ubah tabel jadi context
def df_to_context(title, df):
    if df.empty:
        return f"{title}:\nNo data found."
    rows = []
    for _, row in df.iterrows():
        row_text = ", ".join([
            f"{col}: {row[col]}"
            for col in df.columns
        ])
        rows.append(f"- {row_text}")
    return f"{title}:\n" + "\n".join(rows)

# %%
# ambil context dari neo4j
def get_country_context():
    df = run_cypher("""
    MATCH (o:Occurrence)-[:RECORDED_IN]->(c:Country)
    RETURN c.name AS country, count(o) AS total_occurrence
    ORDER BY total_occurrence DESC
    LIMIT 10
    """)
    return df_to_context("Top countries by occurrence", df)
def get_year_context():
    df = run_cypher("""
    MATCH (o:Occurrence)-[:RECORDED_IN_YEAR]->(y:Year)
    RETURN y.value AS year, count(o) AS total_occurrence
    ORDER BY total_occurrence DESC
    LIMIT 10
    """)
    return df_to_context("Top years by occurrence", df)
def get_species_context():
    df = run_cypher("""
    MATCH (o:Occurrence)-[:OBSERVED_SPECIES]->(s:Species)
    RETURN s.name AS species, count(o) AS total_occurrence
    ORDER BY total_occurrence DESC
    LIMIT 10
    """)
    return df_to_context("Top species by occurrence", df)

# %%
# context hasil graph analysis dan graph ml
def get_pagerank_context():
    country_df = run_cypher("""
    MATCH (c:Country)
    WHERE c.pagerankScore IS NOT NULL
    RETURN c.name AS country, round(c.pagerankScore, 5) AS pagerank_score
    ORDER BY pagerank_score DESC
    LIMIT 10
    """)
    year_df = run_cypher("""
    MATCH (y:Year)
    WHERE y.pagerankScore IS NOT NULL
    RETURN y.value AS year, round(y.pagerankScore, 5) AS pagerank_score
    ORDER BY pagerank_score DESC
    LIMIT 10
    """)
    return (
        df_to_context("PageRank result for Country", country_df)
        + "\n\n"
        + df_to_context("PageRank result for Year", year_df)
    )
def get_similarity_context():
    df = run_cypher("""
    MATCH (s1:Species)-[r:SIMILAR_TO_JACCARD]->(s2:Species)
    RETURN
      s1.name AS species_1,
      s2.name AS species_2,
      round(r.jaccardScore, 4) AS jaccard_score
    ORDER BY jaccard_score DESC
    LIMIT 10
    """)
    return df_to_context("Top Jaccard species similarity", df)
def get_kmeans_context():
    df = run_cypher("""
    MATCH (s:Species)
    WHERE s.mlCluster IS NOT NULL
    OPTIONAL MATCH (s)-[:BELONGS_TO]->(:Genus)-[:BELONGS_TO]->(f:Family)
    OPTIONAL MATCH (s)<-[:OBSERVED_SPECIES]-(o:Occurrence)-[:RECORDED_IN]->(c:Country)
    RETURN
      s.mlCluster AS cluster,
      count(DISTINCT s) AS total_species,
      collect(DISTINCT f.name)[0..10] AS dominant_families,
      collect(DISTINCT c.name)[0..6] AS dominant_countries,
      collect(DISTINCT s.name)[0..10] AS sample_species
    ORDER BY total_species DESC
    """)
    return df_to_context("K-Means clustering result", df)

# %%
# context hasil llm graph builder
def get_graph_builder_context():
    df = run_cypher("""
    MATCH (s:Species)-[r:HAS_HABITAT|HAS_THREAT|FOUND_IN_ENVIRONMENT]->(n)
    RETURN
      s.name AS species,
      type(r) AS relationship,
      labels(n)[0] AS target_label,
      n.name AS target_name
    ORDER BY species, relationship
    LIMIT 50
    """)
    return df_to_context("LLM Graph Builder result", df)

# %%
# fungsi retrieval context
def retrieve_graph_context(question):
    q = question.lower()
    context_parts = []

    # Context umum yang hampir selalu berguna
    context_parts.append(get_country_context())
    context_parts.append(get_year_context())
    context_parts.append(get_species_context())

    # Context tambahan sesuai pertanyaan
    if "pagerank" in q or "centrality" in q or "sentral" in q:
        context_parts.append(get_pagerank_context())
    if "similarity" in q or "jaccard" in q or "mirip" in q:
        context_parts.append(get_similarity_context())
    if "cluster" in q or "klaster" in q or "k-means" in q:
        context_parts.append(get_kmeans_context())
    if "habitat" in q or "threat" in q or "ancaman" in q or "environment" in q:
        context_parts.append(get_graph_builder_context())

    # Kalau pertanyaan minta insight umum, masukkan semua hasil penting
    if "insight" in q or "kesimpulan" in q or "utama" in q:
        context_parts.append(get_pagerank_context())
        context_parts.append(get_similarity_context())
        context_parts.append(get_kmeans_context())
        context_parts.append(get_graph_builder_context())
    return "\n\n".join(context_parts)

# %%
# prompt graphrag
RAG_SYSTEM_PROMPT = """
You are a biodiversity graph analysis assistant.
Answer the user's question using ONLY the Neo4j graph context provided.
Do not use outside knowledge.
If the context is not enough, say that the graph context is not sufficient.
Answer in Indonesian.
Use clear and concise explanation.
"""

# %%
# fungsi graphrag
def answer_with_graphrag(question, show_context=False):
    context = retrieve_graph_context(question)
    messages = [
        {
            "role": "system",
            "content": RAG_SYSTEM_PROMPT
        },
        {
            "role": "user",
            "content": f"""
Graph context from Neo4j:
{context}
User question:
{question}
Answer:
"""
        }
    ]
    response = llm_client.chat.completions.create(
        model=MODEL_NAME,
        messages=messages,
        temperature=0.2,
        max_tokens=900
    )

    answer = response.choices[0].message.content
    print("\nQUESTION:")
    print(question)
    if show_context:
        print("\nRETRIEVED GRAPH CONTEXT:")
        print(context)
    print("\nGRAPH RAG ANSWER:")
    print(answer)
    return answer

# %%
# demo otomatis (mini chatbot)
def start_graphrag_chatbot():
    print("=" * 80)
    print("BIODIVERSITY GRAPH RAG CHATBOT")
    print("=" * 80)
    print("Ketik pertanyaan tentang graph biodiversity.")
    print("Ketik 'exit' untuk keluar.")
    print("=" * 80)

    while True:
        user_question = input("\nMasukkan pertanyaan kamu: ")
        if user_question.lower() in ["exit", "quit", "keluar"]:
            print("\nChatbot selesai.")
            break
        if user_question.strip() == "":
            print("Pertanyaan tidak boleh kosong.")
            continue

        print("\nSedang mengambil context dari Neo4j dan membuat jawaban...\n")
        answer_with_graphrag(user_question)

if __name__ == "__main__":
    start_graphrag_chatbot()
