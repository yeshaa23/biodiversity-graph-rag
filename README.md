# 🌿 Biodiversity GraphRAG: Southeast Asian Biodiversity Knowledge Graph

## Graph Analysis of Southeast Asian Biodiversity Data Using Neo4j, Graph Data Science, LLM Text-to-Cypher, LLM Graph Builder, and GraphRAG

---

### 📄 Deskripsi Proyek

Repositori ini berisi proyek **Knowledge Graph dan GraphRAG** untuk menganalisis data biodiversitas Asia Tenggara menggunakan **Neo4j**, **Neo4j Graph Data Science (GDS)**, **Python**, **Cypher**, dan **Large Language Model (LLM)**.

Project ini membangun **biodiversity knowledge graph** dari data occurrence biodiversitas yang diperoleh dari **GBIF**. Data tersebut direpresentasikan dalam bentuk node dan relationship seperti `Occurrence`, `Species`, `Country`, `Year`, `BasisOfRecord`, serta struktur taksonomi mulai dari `Species`, `Genus`, `Family`, `Order`, `Class`, `Phylum`, hingga `Kingdom`.

Selain membangun graph, project ini juga mengimplementasikan beberapa komponen utama, yaitu **Graph Analytics**, **Graph Machine Learning**, **LLM Text-to-Cypher**, **LLM Graph Builder**, dan **GraphRAG**. Dengan pendekatan ini, data biodiversitas tidak hanya disimpan dalam bentuk tabel, tetapi juga dianalisis melalui hubungan antar entitas dalam graph.

Project ini mencakup:

* ✅ LLM untuk Text-to-Cypher
* ✅ LLM for Graph Builder
* ✅ GraphRAG atau Graph-Augmented Retrieval
* ✅ Graph Analytics menggunakan Neo4j GDS
* ✅ Graph Machine Learning menggunakan FastRP, KNN, dan K-Means

---

### 🛠 Built With

<p align="left">

  <!-- Database -->

  <img src="https://img.shields.io/badge/Neo4j-5.x-008CC1?style=for-the-badge&logo=neo4j&logoColor=white">
  <img src="https://img.shields.io/badge/Neo4j%20GDS-Graph%20Data%20Science-4581C3?style=for-the-badge&logo=neo4j&logoColor=white">

  <br>

  <!-- Programming -->

  <img src="https://img.shields.io/badge/Python-3.x-blue?style=for-the-badge&logo=python&logoColor=white">
  <img src="https://img.shields.io/badge/Cypher-Query%20Language-00BFA5?style=for-the-badge">
  <img src="https://img.shields.io/badge/Jupyter-Notebook-orange?style=for-the-badge&logo=jupyter&logoColor=white">

  <br>

  <!-- Data Processing -->

  <img src="https://img.shields.io/badge/Pandas-Data%20Processing-150458?style=for-the-badge&logo=pandas&logoColor=white">
  <img src="https://img.shields.io/badge/GBIF-Biodiversity%20Dataset-4CAF50?style=for-the-badge">

  <br>

  <!-- AI & LLM -->

  <img src="https://img.shields.io/badge/OpenRouter-LLM%20API-6C63FF?style=for-the-badge">
  <img src="https://img.shields.io/badge/LLM-Text--to--Cypher-purple?style=for-the-badge">
  <img src="https://img.shields.io/badge/LLM-Graph%20Builder-blueviolet?style=for-the-badge">
  <img src="https://img.shields.io/badge/GraphRAG-Graph%20Retrieval-red?style=for-the-badge">

  <br>

  <!-- Tools -->

  <img src="https://img.shields.io/badge/VS%20Code-IDE-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white">
  <img src="https://img.shields.io/badge/GitHub-Repository-black?style=for-the-badge&logo=github&logoColor=white">

</p>

---

### 📂 Struktur File

```bash
biodiversity-graph-rag/
│
├── README.md
├── requirements.txt
├── .gitignore
├── .env.example
│
├── data/                                            
│   ├── processed/                                 
│   │   ├── fastrp-embedding.csv                    
│   │   ├── kmeans-cluster.csv                      
│   │   ├── kmeans-species-context.csv             
│   │   ├── knn-similarity.csv                     
│   │   └── llm-graph-builder-extraction.csv        
│   │
│   ├── gbif_biodiversity_graph.csv                 
│   └── species_descriptions.csv                    
├── scripts/
│   ├── text_to_cypher_debug.py
│   ├── llm_graph_builder.py
│   └── graphrag_demo.py
│
├── cypher/
    ├── 1_graph_insight.cypher
    ├── 2_graph_analytics.cypher
    ├── 3_graph_ml.cypher
    ├── 4_graph_builder_preview.cypher
    └── 5_graphrag_context_queries.cypher
```

---

### 📊 Dataset

Dataset utama yang digunakan adalah data biodiversitas Asia Tenggara yang diperoleh dari **GBIF Occurrence API**. Dataset ini berisi informasi mengenai occurrence atau kemunculan spesies, nama species, struktur taksonomi, negara pencatatan, tahun pencatatan, dan basis pencatatan data.

#### File Dataset

| File                                  | Deskripsi                                                          |
| ------------------------------------- | ------------------------------------------------------------------ |
| `gbif_biodiversity_graph.csv`         | Dataset utama untuk membangun knowledge graph biodiversitas        |
| `species_descriptions.csv`            | Data teks tidak terstruktur berisi deskripsi species               |
| `llm_graph_builder_extraction_15.csv` | Hasil ekstraksi LLM Graph Builder dari 15 sample deskripsi species |

#### Negara dalam Dataset

* Indonesia
* Malaysia
* Singapore
* Thailand
* Viet Nam
* Philippines
---

### 🧩 Entity dan Graph Schema

Knowledge graph pada project ini terdiri dari beberapa node utama dan relationship yang menggambarkan hubungan occurrence biodiversitas dengan species, lokasi, waktu, basis pencatatan, dan struktur taksonomi.

#### Node Utama

| Node Label      | Deskripsi                                             |
| --------------- | ----------------------------------------------------- |
| `Occurrence`    | Data kemunculan atau observasi biodiversitas          |
| `Species`       | Nama species yang diamati                             |
| `Genus`         | Taksonomi genus dari species                          |
| `Family`        | Taksonomi family dari species                         |
| `Order`         | Taksonomi order dari species                          |
| `Class`         | Taksonomi class dari species                          |
| `Phylum`        | Taksonomi phylum dari species                         |
| `Kingdom`       | Taksonomi kingdom dari species                        |
| `Country`       | Negara tempat occurrence dicatat                      |
| `Year`          | Tahun occurrence dicatat                              |
| `BasisOfRecord` | Jenis basis pencatatan data                           |
| `Habitat`       | Habitat hasil ekstraksi LLM Graph Builder             |
| `Threat`        | Ancaman hasil ekstraksi LLM Graph Builder             |
| `Environment`   | Lingkungan ekologis hasil ekstraksi LLM Graph Builder |

#### Relationship Utama

```cypher
(:Occurrence)-[:OBSERVED_SPECIES]->(:Species)
(:Occurrence)-[:RECORDED_IN]->(:Country)
(:Occurrence)-[:RECORDED_IN_YEAR]->(:Year)
(:Occurrence)-[:RECORDED_AS]->(:BasisOfRecord)

(:Species)-[:BELONGS_TO]->(:Genus)
(:Genus)-[:BELONGS_TO]->(:Family)
(:Family)-[:BELONGS_TO]->(:Order)
(:Order)-[:BELONGS_TO]->(:Class)
(:Class)-[:BELONGS_TO]->(:Phylum)
(:Phylum)-[:BELONGS_TO]->(:Kingdom)
```

#### Relationship Tambahan dari LLM Graph Builder

```cypher
(:Species)-[:HAS_HABITAT]->(:Habitat)
(:Species)-[:HAS_THREAT]->(:Threat)
(:Species)-[:FOUND_IN_ENVIRONMENT]->(:Environment)
```

#### Relationship Tambahan dari Graph Similarity

```cypher
(:Species)-[:SIMILAR_TO_JACCARD]->(:Species)
```

---

### 🏗 Arsitektur Sistem

Secara umum, arsitektur project ini dimulai dari pengambilan dataset biodiversitas, preprocessing data, import data ke Neo4j, pembangunan knowledge graph, analisis graph, integrasi LLM, hingga implementasi GraphRAG.

```text
GBIF Biodiversity Dataset
        ↓
Data Cleaning & Preprocessing
        ↓
Import Data ke Neo4j
        ↓
Biodiversity Knowledge Graph
        ↓
Graph Analytics menggunakan Neo4j GDS
        ↓
Graph Machine Learning
        ↓
LLM Text-to-Cypher
        ↓
LLM Graph Builder
        ↓
GraphRAG
        ↓
Jawaban Natural Language Berbasis Context Graph
```

#### Alur GraphRAG

```text
User Question
        ↓
Retrieve context dari Neo4j
        ↓
Context dikirim ke LLM
        ↓
LLM menghasilkan jawaban berbasis graph
```

---

### 🔬 Tahapan Implementasi

#### 1. Data Import dan Knowledge Graph Construction

Tahap pertama adalah membangun knowledge graph dari dataset biodiversitas. Data CSV diimpor ke Neo4j menggunakan Cypher. Setiap baris occurrence diubah menjadi node `Occurrence` yang terhubung dengan `Species`, `Country`, `Year`, dan `BasisOfRecord`.

Selain itu, struktur taksonomi juga dibangun melalui relationship bertingkat dari `Species` hingga `Kingdom`.

Contoh query import:

```cypher
LOAD CSV WITH HEADERS FROM 'file:///gbif_biodiversity_graph.csv' AS row

MERGE (o:Occurrence {occurrenceKey: row.occurrenceKey})
MERGE (s:Species {name: row.species})
MERGE (c:Country {name: row.country})
MERGE (y:Year {value: toInteger(row.year)})

MERGE (o)-[:OBSERVED_SPECIES]->(s)
MERGE (o)-[:RECORDED_IN]->(c)
MERGE (o)-[:RECORDED_IN_YEAR]->(y);
```

---

#### 2. Graph Analytics

Graph analytics dilakukan menggunakan **Neo4j Graph Data Science Plugin**. Analisis ini digunakan untuk memahami pola hubungan antar node dalam biodiversity graph.

##### a. Jaccard Node Similarity

Jaccard similarity digunakan untuk mencari species yang memiliki pola hubungan mirip berdasarkan keterhubungan dengan node lain, seperti country dan family.

Output utama:

* pasangan species
* skor Jaccard similarity
* species dengan tingkat kemiripan tertinggi

##### b. PageRank Centrality

PageRank digunakan untuk melihat node yang paling sentral dalam graph. Pada project ini, PageRank dianalisis terutama pada node `Country` dan `Year`.

Output utama:

* country paling sentral
* year paling sentral
* score PageRank

##### c. Louvain Community Detection

Louvain digunakan untuk mendeteksi komunitas atau kelompok alami dalam graph berdasarkan kepadatan hubungan antar node. Hasil community disimpan pada property `communityId`.

Analisis lanjutan dilakukan untuk melihat:

* jumlah species per community
* country dominan per community
* year dominan per community

---

#### 3. Graph Machine Learning

Graph Machine Learning dilakukan untuk memperoleh representasi vektor dari node dan mengelompokkan species berdasarkan struktur graph.

Pipeline yang digunakan:

```text
Species Similarity Graph
        ↓
FastRP Embedding
        ↓
KNN Similarity Search
        ↓
K-Means Clustering
```

##### a. FastRP Embedding

FastRP digunakan untuk membuat representasi vektor dari node `Species`. Embedding ini membantu model memahami posisi dan kemiripan species berdasarkan struktur graph.

##### b. KNN Similarity Search

KNN digunakan untuk mencari species yang memiliki embedding paling mirip. Hasil ini dapat digunakan untuk melihat species yang memiliki pola hubungan serupa di dalam graph.

##### c. K-Means Clustering

K-Means digunakan untuk mengelompokkan species berdasarkan embedding graph. Hasil cluster disimpan pada property `mlCluster`.

Output utama:

* cluster species
* jumlah species per cluster
* family dominan
* country dominan
* contoh species setiap cluster

---

#### 4. LLM Text-to-Cypher

LLM Text-to-Cypher digunakan untuk menerjemahkan pertanyaan natural language menjadi query Cypher. Dengan komponen ini, pengguna yang tidak memahami Cypher tetap dapat melakukan query terhadap database Neo4j menggunakan bahasa natural.

Contoh pertanyaan:

```text
Negara mana yang memiliki jumlah occurrence paling banyak?
```

Contoh hasil Cypher yang dihasilkan:

```cypher
MATCH (o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN c.name AS country, count(o) AS total_occurrence
ORDER BY total_occurrence DESC
LIMIT 10;
```

Output utama:

* pertanyaan dari user
* query Cypher yang dihasilkan LLM
* hasil query dari Neo4j

---

#### 5. LLM Graph Builder

LLM Graph Builder digunakan untuk mengekstraksi entity dan relationship dari data teks tidak terstruktur berupa deskripsi species.

Input:

```text
Species description
```

Output ekstraksi LLM:

```json
{
  "habitats": [],
  "threats": [],
  "environments": []
}
```

Hasil ekstraksi kemudian dimasukkan ke Neo4j sebagai node dan relationship baru.

```cypher
(:Species)-[:HAS_HABITAT]->(:Habitat)
(:Species)-[:HAS_THREAT]->(:Threat)
(:Species)-[:FOUND_IN_ENVIRONMENT]->(:Environment)
```

Pada implementasi ini, digunakan **15 sample species description** untuk menghindari limit API dan tetap menunjukkan proses Graph Builder.

---

#### 6. GraphRAG

GraphRAG digunakan untuk menjawab pertanyaan pengguna berdasarkan context yang diambil langsung dari Neo4j. Berbeda dari LLM biasa, GraphRAG tidak hanya mengandalkan pengetahuan model, tetapi menggunakan hasil retrieval dari graph agar jawaban lebih sesuai dengan data project.

Context yang diambil dari Neo4j meliputi:

* Top countries by occurrence
* Top years by occurrence
* Top species by occurrence
* PageRank result
* Jaccard similarity result
* K-Means cluster result
* LLM Graph Builder result

Contoh pertanyaan:

```text
Berikan insight utama dari biodiversity graph Asia Tenggara ini.
```

Alur GraphRAG:

```text
User Question
        ↓
Retrieve context dari Neo4j menggunakan Cypher
        ↓
Context dikirim ke LLM
        ↓
LLM menghasilkan jawaban berbasis graph
```

---

### ⚙️ Instalasi

#### 1. Clone repository

```bash
git clone https://github.com/yeshaa23/biodiversity-graph-rag.git
cd biodiversity-graph-rag
```

#### 2. Install dependencies

```bash
pip install -r requirements.txt
```

#### 3. Pastikan Neo4j berjalan

Gunakan:

* Neo4j Desktop
* Neo4j versi 5.x
* Graph Data Science Plugin aktif

#### 4. Buat file `.env`

Buat file `.env` berdasarkan `.env.example`.

```env
OPENROUTER_API_KEY=your_openrouter_api_key_here
OPENROUTER_MODEL=openai/gpt-oss-120b:free

NEO4J_URI=neo4j://127.0.0.1:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your_neo4j_password_here
NEO4J_DATABASE=neo4j
```

> Jangan upload file `.env` ke GitHub karena berisi API key dan password Neo4j.

---

### ▶️ Cara Menjalankan Project

#### 1. Import data ke Neo4j

Jalankan query pada file:

```text
cypher/01_import_graph.cypher
```

Kemudian cek database dengan:

```text
cypher/00_database_check.cypher
```

---

#### 2. Jalankan Graph Analytics

Jalankan file:

```text
cypher/02_graph_analytics.cypher
```

File ini berisi:

* Jaccard Node Similarity
* PageRank Centrality
* Louvain Community Detection

---

#### 3. Jalankan Graph Machine Learning

Jalankan file:

```text
cypher/03_graph_ml.cypher
```

File ini berisi:

* FastRP Embedding
* KNN Similarity Search
* K-Means Clustering

---

#### 4. Jalankan Text-to-Cypher

```bash
python scripts/text_to_cypher_debug.py
```

Output yang diharapkan:

```text
QUESTION
GENERATED CYPHER
QUERY RESULT
```

---

#### 5. Jalankan LLM Graph Builder

```bash
python scripts/llm_graph_builder.py
```

Output yang diharapkan:

* hasil ekstraksi habitat, threat, dan environment
* file `llm_graph_builder_extraction_15.csv`
* node `Habitat`, `Threat`, dan `Environment` masuk ke Neo4j

---

#### 6. Jalankan GraphRAG Mini Chatbot

```bash
python scripts/graphrag_demo.py
```

Contoh pertanyaan:

```text
Berikan insight utama dari biodiversity graph Asia Tenggara ini.
```

```text
Negara dan tahun mana yang paling dominan dalam data occurrence?
```

```text
Jelaskan hasil cluster K-Means pada species dalam graph ini.
```

```text
Apa hasil LLM Graph Builder terkait habitat, threat, dan environment?
```

Untuk keluar dari chatbot:

```text
exit
```

---

### 📝 Hasil Utama

#### Dataset dan Graph

* Graph memiliki lebih dari 50 node dan lebih dari 3 jenis entity.
* Entity utama meliputi `Occurrence`, `Species`, `Country`, `Year`, dan struktur taksonomi.
* Graph juga diperkaya dengan node hasil LLM Graph Builder seperti `Habitat`, `Threat`, dan `Environment`.

#### Graph Analytics

* Jaccard similarity berhasil menemukan pasangan species dengan pola hubungan serupa.
* PageRank berhasil menunjukkan country dan year yang paling sentral dalam graph.
* Louvain berhasil membagi node ke dalam community berdasarkan struktur graph.

#### Graph Machine Learning

* FastRP berhasil menghasilkan embedding untuk node `Species`.
* KNN berhasil menemukan species yang memiliki embedding mirip.
* K-Means berhasil mengelompokkan species ke dalam 3 cluster.

#### LLM Integration

* Text-to-Cypher berhasil menerjemahkan pertanyaan natural language menjadi query Cypher.
* LLM Graph Builder berhasil mengekstraksi habitat, threat, dan environment dari teks deskripsi species.
* GraphRAG berhasil menjawab pertanyaan berdasarkan context yang diambil dari Neo4j.

---

### 💡 Insight Project

Berdasarkan hasil implementasi, knowledge graph membantu merepresentasikan data biodiversitas secara lebih terstruktur karena setiap occurrence dapat dihubungkan dengan species, negara, tahun, basis pencatatan, dan struktur taksonomi. Graph analytics menunjukkan adanya pola keterhubungan antar species, country, dan year, sedangkan graph machine learning membantu menemukan kemiripan dan cluster species berdasarkan struktur graph.

Integrasi LLM melalui Text-to-Cypher, Graph Builder, dan GraphRAG membuat project ini tidak hanya berfokus pada penyimpanan data, tetapi juga mendukung eksplorasi berbasis pertanyaan natural language. Dengan GraphRAG, jawaban yang dihasilkan LLM menjadi lebih terarah karena menggunakan context yang diambil dari Neo4j.

---

### 🤖 Dokumentasi Penggunaan AI

AI digunakan untuk membantu proses pengembangan kode, penyusunan query Cypher, pembuatan pipeline LLM, dan penyusunan dokumentasi.

#### Model yang Digunakan

Model LLM yang digunakan melalui OpenRouter API:

```text
openai/gpt-oss-120b:free
```

Model dapat disesuaikan melalui konfigurasi:

```text
OPENROUTER_MODEL
```

#### Contoh Prompt yang Digunakan

```text
Buatkan kode Python untuk Text-to-Cypher menggunakan OpenRouter dan Neo4j.
```

```text
Buatkan pipeline LLM Graph Builder untuk mengekstraksi habitat, threat, dan environment dari species description.
```

```text
Buatkan GraphRAG pipeline yang mengambil context dari Neo4j dan menjawab pertanyaan berdasarkan data graph.
```

```text
Buatkan query Cypher untuk Graph Analytics menggunakan Jaccard similarity, PageRank, dan Louvain Community Detection.
```

```text
Buatkan query Cypher untuk Graph Machine Learning menggunakan FastRP, KNN, dan K-Means.
```

#### Modifikasi Manual

Beberapa modifikasi manual yang dilakukan:

* Menyesuaikan graph schema dengan dataset biodiversitas.
* Menyesuaikan node dan relationship berdasarkan struktur Neo4j yang dibuat.
* Menambahkan validasi agar Text-to-Cypher hanya menjalankan query read-only.
* Membatasi LLM Graph Builder pada 15 sample untuk menghindari limit API.
* Menyesuaikan context retrieval GraphRAG berdasarkan country, year, species, PageRank, similarity, cluster, habitat, threat, dan environment.
* Menyimpan API key dan password di `.env` agar tidak terunggah ke GitHub.

---

### 🎥 Video Demo

Link YouTube:

```text
Masukkan link YouTube di sini
```

Struktur video demo:

### 👥 Author

| Nama               | NRP          |
| ------------------ | -------------|
| Ayesha Hana Azkiya | 5026231125   |
| Amandea Chandiki L | 5026231139   |

---
