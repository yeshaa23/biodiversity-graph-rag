# 🌿 Biodiversity GraphRAG: Southeast Asian Biodiversity Knowledge Graph

## Graph Analysis of Southeast Asian Biodiversity Data Using Neo4j, Graph Data Science, LLM Text-to-Cypher, LLM Graph Builder, and GraphRAG

---

### 📄 Deskripsi Proyek

Repositori ini berisi proyek **Knowledge Graph dan GraphRAG** untuk menganalisis data biodiversitas Asia Tenggara menggunakan **Neo4j**, **Neo4j Graph Data Science (GDS)**, **Python**, **Cypher**, dan **Large Language Model (LLM)**.

Project ini membangun **biodiversity knowledge graph** dari data occurrence biodiversitas yang diperoleh dari **GBIF Occurrence API**. Data tersebut direpresentasikan dalam bentuk node dan relationship seperti `Occurrence`, `Species`, `Country`, `Year`, `BasisOfRecord`, serta struktur taksonomi mulai dari `Species`, `Genus`, `Family`, `Order`, `Class`, `Phylum`, hingga `Kingdom`.

Selain membangun graph, project ini juga mengimplementasikan beberapa komponen utama, yaitu **Graph Analytics**, **Graph Machine Learning**, **LLM Text-to-Cypher**, **LLM Graph Builder**, dan **GraphRAG**. Dengan pendekatan ini, data biodiversitas tidak hanya disimpan dalam bentuk tabel, tetapi juga dianalisis melalui hubungan antarentitas dalam graph.

Project ini mencakup:

- ✅ LLM untuk Text-to-Cypher  
- ✅ LLM for Graph Builder  
- ✅ GraphRAG atau Graph-Augmented Retrieval  
- ✅ Graph Analytics menggunakan Neo4j GDS  
- ✅ Graph Machine Learning menggunakan FastRP, KNN, dan K-Means  

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
├── cypher/
│   ├── 1-graph-insight.cypher
│   ├── 2-graph-analytics.cypher
│   ├── 3-graph-ml.cypher
│   ├── 4-graph-builder-preview.cypher
│   └── 5-graphrag-context-queries.cypher
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
│
├── notebook/
│   ├── 1-biodiversity-data-graf.ipynb
│   ├── 2-text-to-cypher.ipynb
│   ├── 3-llm-graph-builder.ipynb
│   ├── 4a-graphrag_demo.ipynb
│   └── 4b-graphrag_demo.py
│
├── .env.example
├── .gitignore
└── README.md
```

---

### 📊 Dataset

Dataset utama yang digunakan adalah data biodiversitas Asia Tenggara yang diperoleh dari **GBIF Occurrence API**. Dataset ini berisi informasi mengenai occurrence atau kemunculan spesies, nama species, struktur taksonomi, negara pencatatan, tahun pencatatan, dan basis pencatatan data.

Dataset digunakan untuk membangun knowledge graph biodiversitas di Neo4j. Setiap baris data occurrence direpresentasikan sebagai node `Occurrence` yang terhubung dengan node lain seperti `Species`, `Country`, `Year`, `BasisOfRecord`, dan struktur taksonomi.

#### File Dataset Utama

| File | Deskripsi |
|------|----------|
| `data/gbif_biodiversity_graph.csv` | Dataset utama GBIF yang digunakan untuk membangun biodiversity knowledge graph |
| `data/species_descriptions.csv` | Data teks tidak terstruktur berisi deskripsi species untuk kebutuhan LLM Graph Builder |

#### File Hasil Pemrosesan

| File | Deskripsi |
|------|----------|
| `data/processed/fastrp-embedding.csv` | Hasil embedding node `Species` menggunakan FastRP |
| `data/processed/kmeans-cluster.csv` | Hasil clustering species menggunakan algoritma K-Means |
| `data/processed/kmeans-species-context.csv` | Ringkasan context cluster species yang digunakan untuk analisis dan GraphRAG |
| `data/processed/knn-similarity.csv` | Hasil KNN similarity antar species berdasarkan embedding FastRP |
| `data/processed/llm-graph-builder-extraction.csv` | Hasil ekstraksi LLM Graph Builder dari deskripsi species |

#### Negara dalam Dataset

- Indonesia  
- Malaysia  
- Singapore  
- Thailand  
- Viet Nam  
- Philippines  

Dataset ini memenuhi ketentuan project karena memiliki lebih dari **50 node** dan lebih dari **3 jenis entitas berbeda**, seperti `Occurrence`, `Species`, `Country`, `Year`, `BasisOfRecord`, serta struktur taksonomi.

---

### 📓 Notebook dan File Eksekusi

Folder `notebook/` berisi file eksekusi utama yang digunakan dalam proses pembangunan graph, integrasi LLM, dan implementasi GraphRAG.

| File | Deskripsi |
|------|----------|
| `1-biodiversity-data-graf.ipynb` | Notebook untuk eksplorasi dataset biodiversitas, preprocessing, import data, dan pembentukan biodiversity knowledge graph |
| `2-text-to-cypher.ipynb` | Notebook implementasi LLM Text-to-Cypher untuk menerjemahkan pertanyaan bahasa alami menjadi query Cypher |
| `3-llm-graph-builder.ipynb` | Notebook implementasi LLM Graph Builder untuk mengekstraksi habitat, threat, dan environment dari deskripsi species |
| `4a-graphrag_demo.ipynb` | Notebook demo GraphRAG untuk mengambil context dari Neo4j dan menghasilkan jawaban berbasis graph |
| `4b-graphrag_demo.py` | Script Python GraphRAG mini chatbot yang dapat dijalankan melalui terminal |

---

### 🧩 Entity dan Graph Schema

Knowledge graph pada project ini terdiri dari beberapa node utama dan relationship yang menggambarkan hubungan occurrence biodiversitas dengan species, lokasi, waktu, basis pencatatan, dan struktur taksonomi.

#### Node Utama

| Node Label | Deskripsi |
|-----------|-----------|
| `Occurrence` | Data kemunculan atau observasi biodiversitas |
| `Species` | Nama species yang diamati |
| `Genus` | Taksonomi genus dari species |
| `Family` | Taksonomi family dari species |
| `Order` | Taksonomi order dari species |
| `Class` | Taksonomi class dari species |
| `Phylum` | Taksonomi phylum dari species |
| `Kingdom` | Taksonomi kingdom dari species |
| `Country` | Negara tempat occurrence dicatat |
| `Year` | Tahun occurrence dicatat |
| `BasisOfRecord` | Jenis basis pencatatan data |
| `Habitat` | Habitat hasil ekstraksi LLM Graph Builder |
| `Threat` | Ancaman hasil ekstraksi LLM Graph Builder |
| `Environment` | Lingkungan ekologis hasil ekstraksi LLM Graph Builder |

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
Retrieve context dari Neo4j menggunakan Cypher
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

---

#### 2. Graph Analytics

Graph analytics dilakukan menggunakan **Neo4j Graph Data Science Plugin**. Analisis ini digunakan untuk memahami pola hubungan antar node dalam biodiversity graph.

Analisis yang digunakan:

- **Jaccard Node Similarity** untuk mencari pasangan species yang memiliki pola hubungan mirip.
- **PageRank Centrality** untuk melihat node yang paling sentral dalam graph, terutama `Country` dan `Year`.
- **Louvain Community Detection** untuk mendeteksi komunitas atau kelompok alami dalam graph berdasarkan kepadatan hubungan antar node.

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

---

#### 4. LLM Text-to-Cypher

LLM Text-to-Cypher digunakan untuk menerjemahkan pertanyaan natural language menjadi query Cypher. Dengan komponen ini, pengguna yang tidak memahami Cypher tetap dapat melakukan query terhadap database Neo4j menggunakan bahasa natural.

Contoh pertanyaan:

```text
Negara mana yang memiliki jumlah occurrence paling banyak?
```

Contoh query Cypher:

```cypher
MATCH (o:Occurrence)-[:RECORDED_IN]->(c:Country)
RETURN c.name AS country, count(o) AS total_occurrence
ORDER BY total_occurrence DESC
LIMIT 10;
```

---

#### 5. LLM Graph Builder

LLM Graph Builder digunakan untuk mengekstraksi entity dan relationship dari data teks tidak terstruktur berupa deskripsi species. Informasi yang diekstraksi meliputi habitat, threat, dan environment.

Hasil ekstraksi kemudian dimasukkan ke Neo4j sebagai node dan relationship baru:

```cypher
(:Species)-[:HAS_HABITAT]->(:Habitat)
(:Species)-[:HAS_THREAT]->(:Threat)
(:Species)-[:FOUND_IN_ENVIRONMENT]->(:Environment)
```

Pada implementasi ini, digunakan **15 sample species description** untuk menghindari limit API dan tetap menunjukkan proses Graph Builder.

---

#### 6. GraphRAG

GraphRAG digunakan untuk menjawab pertanyaan pengguna berdasarkan context yang diambil langsung dari Neo4j. Context yang diambil dari Neo4j meliputi:

- Top countries by occurrence  
- Top years by occurrence  
- Top species by occurrence  
- PageRank result  
- Jaccard similarity result  
- K-Means cluster result  
- LLM Graph Builder result  

---

### ⚙️ Instalasi dan Konfigurasi

#### 1. Clone repository

```bash
git clone https://github.com/yeshaa23/biodiversity-graph-rag.git
cd biodiversity-graph-rag
```

#### 2. Install dependencies

Install library utama berikut:

```bash
pip install pandas python-dotenv openai neo4j jupyter
```

#### 3. Pastikan Neo4j berjalan

Gunakan:

- Neo4j Desktop  
- Neo4j versi 5.x  
- Graph Data Science Plugin aktif  

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

#### 1. Import dan cek data graph

Jalankan notebook:

```text
notebook/1-biodiversity-data-graf.ipynb
```

Untuk menjalankan query insight awal, gunakan file:

```text
cypher/1-graph-insight.cypher
```

---

#### 2. Jalankan Graph Analytics

Jalankan file:

```text
cypher/2-graph-analytics.cypher
```

File ini berisi:

- Jaccard Node Similarity  
- PageRank Centrality  
- Louvain Community Detection  

---

#### 3. Jalankan Graph Machine Learning

Jalankan file:

```text
cypher/3-graph-ml.cypher
```

File ini berisi:

- FastRP Embedding  
- KNN Similarity Search  
- K-Means Clustering  

Hasil pemrosesan Graph ML disimpan pada folder:

```text
data/processed/
```

---

#### 4. Jalankan Text-to-Cypher

Jalankan notebook:

```text
notebook/2-text-to-cypher.ipynb
```

Output yang diharapkan:

```text
QUESTION
GENERATED CYPHER
QUERY RESULT
```

---

#### 5. Jalankan LLM Graph Builder

Jalankan notebook:

```text
notebook/3-llm-graph-builder.ipynb
```

Output yang diharapkan:

- hasil ekstraksi habitat, threat, dan environment  
- file `data/processed/llm-graph-builder-extraction.csv`  
- node `Habitat`, `Threat`, dan `Environment` masuk ke Neo4j  

Untuk preview hasil Graph Builder, gunakan file:

```text
cypher/4-graph-builder-preview.cypher
```

---

#### 6. Jalankan GraphRAG

GraphRAG dapat dijalankan melalui notebook:

```text
notebook/4a-graphrag_demo.ipynb
```

Atau melalui script Python:

```bash
python notebook/4b-graphrag_demo.py
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

Untuk query context GraphRAG, gunakan file:

```text
cypher/5-graphrag-context-queries.cypher
```

---

### 📝 Hasil Utama

#### Dataset dan Graph

- Graph memiliki lebih dari 50 node dan lebih dari 3 jenis entity.
- Entity utama meliputi `Occurrence`, `Species`, `Country`, `Year`, `BasisOfRecord`, dan struktur taksonomi.
- Graph juga diperkaya dengan node hasil LLM Graph Builder seperti `Habitat`, `Threat`, dan `Environment`.

#### Graph Analytics

- Jaccard Node Similarity berhasil menemukan pasangan species dengan pola hubungan serupa.
- PageRank Centrality berhasil menunjukkan country dan year yang paling sentral dalam graph.
- Louvain Community Detection berhasil membagi node ke dalam community berdasarkan struktur graph.

#### Graph Machine Learning

- FastRP berhasil menghasilkan embedding untuk node `Species`.
- KNN berhasil menemukan species yang memiliki embedding mirip.
- K-Means berhasil mengelompokkan species ke dalam 3 cluster.

#### LLM Integration

- Text-to-Cypher berhasil menerjemahkan pertanyaan natural language menjadi query Cypher.
- LLM Graph Builder berhasil mengekstraksi habitat, threat, dan environment dari teks deskripsi species.
- GraphRAG berhasil menjawab pertanyaan berdasarkan context yang diambil dari Neo4j.

---

### 💡 Insight Project

Berdasarkan hasil implementasi, knowledge graph membantu merepresentasikan data biodiversitas secara lebih terstruktur karena setiap occurrence dapat dihubungkan dengan species, negara, tahun, basis pencatatan, dan struktur taksonomi. Graph analytics menunjukkan adanya pola keterhubungan antar species, country, dan year, sedangkan graph machine learning membantu menemukan kemiripan dan cluster species berdasarkan struktur graph.

Integrasi LLM melalui Text-to-Cypher, Graph Builder, dan GraphRAG membuat project ini tidak hanya berfokus pada penyimpanan data, tetapi juga mendukung eksplorasi berbasis pertanyaan natural language. Dengan GraphRAG, jawaban yang dihasilkan LLM menjadi lebih terarah karena menggunakan context yang diambil dari Neo4j.

---

### 🤖 Dokumentasi Penggunaan AI

AI digunakan sebagai alat bantu dalam proses pengerjaan project, terutama untuk membantu membuat draft awal kode, query Cypher, dan pipeline integrasi LLM. Setelah kode atau query dibuat, anggota kelompok tetap melakukan penyesuaian manual sesuai struktur dataset, graph schema, nama node, nama relationship, serta kebutuhan analisis pada project biodiversitas. AI juga digunakan untuk membantu debugging ketika terdapat error pada kode Python, koneksi Neo4j, query Cypher, pipeline Graph Data Science, Text-to-Cypher, LLM Graph Builder, dan GraphRAG.

Dengan demikian, penggunaan AI pada project ini tidak dilakukan secara langsung tanpa validasi. Hasil bantuan AI tetap diperiksa, dijalankan, diperbaiki, dan disesuaikan secara manual agar sesuai dengan implementasi sebenarnya di Neo4j dan VS Code/Jupyter Notebook.

#### Model yang Digunakan

Model LLM yang digunakan melalui OpenRouter API:

```text
openai/gpt-oss-120b:free
```

Model dapat disesuaikan melalui konfigurasi:

```text
OPENROUTER_MODEL
```

#### Ringkasan Kontribusi AI dan Modifikasi Manual

| Komponen / File | Bantuan AI | Modifikasi Manual |
|-----------------|------------|------------------|
| `cypher/1-graph-insight.cypher` | Membantu membuat draft query awal untuk mengecek jumlah node, relationship, country, year, dan species. | Menyesuaikan label node, relationship, dan property sesuai graph yang terbentuk di Neo4j. |
| `cypher/2-graph-analytics.cypher` | Membantu membuat dan memperbaiki query Graph Analytics seperti Jaccard Similarity, PageRank Centrality, dan Louvain Community Detection. | Menyesuaikan graph projection, memilih relationship yang relevan, menjalankan algoritma GDS, dan menginterpretasikan hasil secara manual. |
| `cypher/3-graph-ml.cypher` | Membantu membuat draft pipeline Graph Machine Learning menggunakan FastRP, KNN, dan K-Means serta membantu debugging jika query error. | Menyesuaikan property embedding, jumlah cluster, output CSV, dan interpretasi hasil clustering. |
| `cypher/4-graph-builder-preview.cypher` | Membantu membuat query preview untuk melihat hasil entity dan relationship dari LLM Graph Builder. | Menyesuaikan entity yang digunakan, yaitu `Habitat`, `Threat`, dan `Environment`, sesuai hasil ekstraksi dari species description. |
| `cypher/5-graphrag-context-queries.cypher` | Membantu membuat query context retrieval untuk GraphRAG. | Menentukan context yang digunakan, seperti country dominan, year dominan, top species, hasil PageRank, similarity, cluster, dan hasil Graph Builder. |
| `notebook/1-biodiversity-data-graf.ipynb` | Membantu membuat draft kode eksplorasi dataset, preprocessing, dan pembentukan graph. | Menyesuaikan path file, membersihkan data, memeriksa kolom dataset, menjalankan import, dan memastikan data berhasil masuk ke Neo4j. |
| `notebook/2-text-to-cypher.ipynb` | Membantu membuat draft alur Text-to-Cypher menggunakan OpenRouter dan Neo4j serta membantu debugging output query. | Menambahkan schema graph sebagai context, menguji pertanyaan, menjalankan query hasil LLM ke Neo4j, dan memastikan hasil sesuai data. |
| `notebook/3-llm-graph-builder.ipynb` | Membantu membuat draft pipeline ekstraksi habitat, threat, dan environment dari deskripsi species. | Menentukan sample species, membatasi 15 data, memvalidasi hasil ekstraksi, dan menyesuaikan hasilnya menjadi node serta relationship di Neo4j. |
| `notebook/4a-graphrag_demo.ipynb` dan `4b-graphrag_demo.py` | Membantu membuat draft alur retrieval context dari Neo4j, prompt GraphRAG, dan format jawaban. | Menentukan context yang diambil dari Neo4j, menyesuaikan prompt, menjalankan demo, dan memastikan jawaban tetap berbasis data graph. |
| `README.md` | Membantu merapikan struktur dokumentasi, instalasi, konfigurasi, cara menjalankan, arsitektur, dan dokumentasi penggunaan AI. | Menyesuaikan isi README dengan struktur repository final, nama file sebenarnya, hasil eksekusi, dan implementasi project yang dilakukan. |

#### Contoh Prompt yang Digunakan

Beberapa contoh prompt yang digunakan selama proses pengerjaan adalah sebagai berikut:

```text
Buatkan kode Python untuk menghubungkan OpenRouter API dengan Neo4j.
```

```text
Buatkan draft kode Text-to-Cypher untuk menerjemahkan pertanyaan natural language menjadi query Cypher berdasarkan schema graph biodiversity.
```

```text
Buatkan GraphRAG sederhana yang mengambil context dari Neo4j lalu menjawab pertanyaan user berdasarkan data graph.
```

```text
Tolong perbaiki error pada kode koneksi Neo4j dan OpenRouter berikut.
```

```text
Tolong cek query Cypher ini, kenapa tidak bisa dijalankan di Neo4j GDS?
```

```text
Tolong bantu debugging kode GraphRAG agar context dari Neo4j bisa dikirim ke LLM dan menghasilkan jawaban berbasis data graph.
```

#### Modifikasi Manual yang Dilakukan

Beberapa modifikasi manual yang dilakukan dalam project ini adalah:

- Menentukan topik project, yaitu analisis data biodiversitas Asia Tenggara menggunakan Neo4j dan GraphRAG.
- Menggunakan dataset biodiversitas dari GBIF dan menyesuaikan data agar dapat direpresentasikan sebagai knowledge graph.
- Menentukan graph schema, seperti node `Occurrence`, `Species`, `Country`, `Year`, `BasisOfRecord`, `Genus`, `Family`, `Order`, `Class`, `Phylum`, dan `Kingdom`.
- Menentukan relationship utama, seperti `OBSERVED_SPECIES`, `RECORDED_IN`, `RECORDED_IN_YEAR`, `RECORDED_AS`, dan `BELONGS_TO`.
- Menjalankan query Cypher langsung di Neo4j dan mengecek hasil node serta relationship yang terbentuk.
- Menjalankan Graph Analytics menggunakan Jaccard Node Similarity, PageRank Centrality, dan Louvain Community Detection.
- Menjalankan Graph Machine Learning menggunakan FastRP, KNN, dan K-Means.
- Membatasi LLM Graph Builder pada 15 sample deskripsi species untuk menghindari limit API.
- Memvalidasi hasil ekstraksi LLM Graph Builder dan menyesuaikannya menjadi node `Habitat`, `Threat`, dan `Environment`.
- Menentukan context yang digunakan dalam GraphRAG, seperti top country, top year, top species, PageRank, Jaccard similarity, K-Means cluster, dan hasil Graph Builder.
- Menginterpretasikan hasil analisis graph dan hasil GraphRAG secara manual dalam laporan.
- Menyimpan API key dan password Neo4j pada file `.env`, serta hanya menyediakan `.env.example` di repository.
- Menyesuaikan README dengan struktur folder final dan isi repository yang sebenarnya.

#### Catatan Penggunaan AI

AI pada project ini digunakan sebagai **coding assistant, debugging assistant, dan documentation assistant**. Kode dan query yang dibantu oleh AI tetap dijalankan, diperiksa, serta disesuaikan secara manual agar sesuai dengan dataset, schema graph, dan hasil implementasi di Neo4j. Oleh karena itu, AI berperan sebagai alat bantu dalam proses pengembangan, bukan sebagai pengganti proses analisis dan validasi yang dilakukan oleh anggota kelompok.

---

### 🎥 Video Demo

Link YouTube:

```text
https://youtube.com/playlist?list=PLge6uSjSJzBW6WpcQmjQTb3hhvQ4BBRcY&si=V0bW7bKplQStH__Q
```

### 👥 Author

| Nama | NRP |
|------|-----|
| Ayesha Hana Azkiya | 5026231125 |
| Amandea Chandiki Larasati | 5026231139 |

---
