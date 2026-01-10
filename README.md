# PageRank Implementation using MPI with Map/Reduce Pattern

[![MPI](https://img.shields.io/badge/MPI-Parallel_Computing-blue.svg)](https://www.mpi-forum.org/)
[![Python](https://img.shields.io/badge/Python-3.x-green.svg)](https://www.python.org/)
[![SLURM](https://img.shields.io/badge/SLURM-HPC_Scheduler-orange.svg)](https://slurm.schedmd.com/)

## 🚀 Project Overview

This project implements the **PageRank algorithm** using **MPI (Message Passing Interface)** with a **Map/Reduce pattern** for parallel computation. The implementation demonstrates distributed computing concepts by calculating webpage rankings across multiple processes, making it suitable for high-performance computing (HPC) environments.

## 📊 What is PageRank?

PageRank is Google's original algorithm for ranking web pages in search results. It works by:
- Treating the web as a graph where pages are nodes and links are edges
- Computing the "importance" of each page based on the links pointing to it
- Using the **taxation method** with a damping factor to prevent rank sinking

## 🏗️ Architecture & Algorithm

### Core Algorithm Implementation
- **Algorithm**: PageRank with Taxation Method
- **Damping Factor (β)**: 0.9 
- **Iterations**: 4 Map/Reduce cycles
- **Parallel Pattern**: MPI-based distributed computation

### Map/Reduce Workflow
```
1. MAP Phase: Each process handles a subset of nodes
2. REDUCE Phase: Aggregate contributions from all processes  
3. UPDATE Phase: Calculate new PageRank values
4. BROADCAST Phase: Distribute updated values to all processes
```

### Mathematical Formula
```
PR(i) = (1-β)/N + β × Σ(PR(j)/L(j))
```
Where:
- `PR(i)` = PageRank of page i
- `β` = Damping factor (0.9)
- `N` = Total number of pages
- `PR(j)` = PageRank of page j linking to page i
- `L(j)` = Number of outbound links from page j

## 🛠️ Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Language** | Python 3.x | Core implementation |
| **Parallelization** | MPI4Py | Message passing interface |
| **Job Scheduler** | SLURM | HPC job management |
| **Data Format** | CSV/Text | Graph edge list input |
| **Output Format** | JSON + Text | Results storage |

### Dependencies
```python
- mpi4py          # MPI bindings for Python
- collections     # Data structures (defaultdict)
- json           # JSON output formatting
- os             # File system operations
```

## 🎯 Key Features

- **✅ Scalable Architecture**: Works with arbitrary number of MPI processes
- **✅ Load Balancing**: Distributes nodes evenly across processes
- **✅ Memory Efficient**: Processes only assigned node subsets
- **✅ Fault Tolerant**: Error handling and validation
- **✅ HPC Ready**: SLURM integration for cluster deployment
- **✅ Multiple Output Formats**: Text and JSON results

## 📁 Project Structure

```
project2/
├── pagerank_project2.py      # Main PageRank implementation
├── project2.slurm            # SLURM job submission script
├── Analysis_Report.pdf       # Detailed project analysis
├── Project2_description.pdf  # Requirements specification
└── README.md                # This documentation
```

## 🚀 Usage

### Running on HPC Cluster
```bash
# Submit job to SLURM scheduler
sbatch project2.slurm
```

### Local MPI Execution
```bash
# Run with 5 processes
mpirun -np 5 python pagerank_project2.py
```

### Configuration Parameters
```python
DAMPING_FACTOR = 0.9    # Taxation method beta value
NUM_ITERATIONS = 4      # Map/reduce iterations
PROCESSES = 5           # Number of MPI processes
```

## 📊 Input/Output

### Input Format
- **Data Files**: `data1.txt` to `data6.txt`
- **Format**: CSV with source,destination pairs
- **Example**:
  ```
  1,2
  1,3  
  2,3
  3,1
  ```

### Output Files
1. **`pagerank_top10_results.txt`**: Top 10 webpages with highest PageRank
2. **`pagerank_results.json`**: Complete results in JSON format

### Sample Output
```
Top 10 Webpages with Largest PageRank Values:
Rank   Webpage ID   PageRank Value      
------ ------------ -------------------
1      12345        0.0456789012
2      67890        0.0234567890
3      11111        0.0198765432
...
```

## ⚡ Performance Characteristics

- **Parallel Efficiency**: Linear scaling with MPI processes
- **Memory Usage**: O(N/P) per process where N=nodes, P=processes
- **Time Complexity**: O(I × N × E/P) where I=iterations, E=edges
- **Convergence**: 4 iterations for stable rankings

## 🔧 HPC Environment Setup

### Required Modules
```bash
module purge
module load anaconda/2
module load mvapich2/gcc/64/2.2rc1
```

### SLURM Configuration
```bash
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=short-40core
```

## 📈 Results & Analysis

The implementation successfully:
- Processes large-scale web graph data
- Identifies top-ranking webpages using PageRank algorithm
- Demonstrates parallel computing efficiency
- Validates results through taxation method convergence

## 🎓 Academic Context

**Course**: AMS598 - Advanced Computational Methods  
**Semester**: Fall 2025  
**Focus Areas**: 
- Parallel Algorithm Design
- High-Performance Computing
- Graph Theory Applications
- Distributed Systems

## 🤝 Contributing

This is an academic project, but suggestions for improvements are welcome:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📝 License

This project is created for academic purposes. Please refer to your institution's academic integrity policies.

---

**Author**: Gunjan Deshpande  
**Course**: AMS598 - Fall 2025  
**Implementation**: MPI-based PageRank with Map/Reduce Pattern
