#!/bin/bash
#SBATCH --job-name=project2_pagerank
#SBATCH --output=project2_pagerank_%j.out
#SBATCH --error=project2_pagerank_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=short-40core
#SBATCH --account=class_ams598

# ========================================
# PROJECT 2: PageRank Implementation
# AMS598 - Fall 2025
# Author: Gunjan Deshpande
# ========================================

echo "=========================================="
echo "PROJECT 2: PageRank with MPI Map/Reduce"
echo "Job ID: $SLURM_JOB_ID"
echo "Started at: $(date)"
echo "Node: $SLURM_JOB_NODELIST"
echo "MPI Tasks: $SLURM_NTASKS"
echo "Data Directory: /gpfs/projects/AMS598/projects2025_data/project2_data/"
echo "Output Directory: /gpfs/projects/AMS598/class2025/Deshpande_Gunjan/"
echo "=========================================="

# Load required modules as specified
module purge
module load anaconda/2
module load mvapich2/gcc/64/2.2rc1

# Verify data directory exists
DATA_DIR="/gpfs/projects/AMS598/projects2025_data/project2_data/"
if [ ! -d "$DATA_DIR" ]; then
    echo "ERROR: Data directory not found: $DATA_DIR"
    exit 1
fi

# Create output directory
OUTPUT_DIR="/gpfs/projects/AMS598/class2025/Deshpande_Gunjan"
mkdir -p $OUTPUT_DIR


cp pagerank_project2.py $OUTPUT_DIR/

echo "Data files available:"
ls -la $DATA_DIR

echo "=========================================="
echo "Testing Python environment and imports..."
python3 -c "
try:
    from mpi4py import MPI
    from collections import defaultdict
    import json, os
    print('✓ All required imports successful')
    print('✓ MPI version:', MPI.Get_version())
except ImportError as e:
    print('✗ Import error:', e)
    exit(1)
"

echo "=========================================="
echo "Launching PageRank computation with MPI..."
echo "Configuration:"
echo "  - Processes: 5"
echo "  - Beta (damping factor): 0.9 (taxation method)"
echo "  - Iterations: 4 map/reduce iterations"
echo "  - Input: $DATA_DIR"
echo "  - Output: $OUTPUT_DIR"
echo "=========================================="


mpirun -np 5 python pagerank_project2.py


if [ $? -eq 0 ]; then
    echo "=========================================="
    echo "✓ PageRank computation completed successfully!"
    echo "Completed at: $(date)"
    
    
    echo ""
    echo "RESULTS - Top 10 WebPages with Largest PageRank Values:"
    echo "======================================================="
    
    # Check for results file in output directory
    if [ -f "$OUTPUT_DIR/pagerank_top10_results.txt" ]; then
        cat "$OUTPUT_DIR/pagerank_top10_results.txt"
    elif [ -f "pagerank_top10_results.txt" ]; then
        cat "pagerank_top10_results.txt"
    else
        echo "Results file not found. Checking for any output files..."
        ls -la $OUTPUT_DIR/
    fi
    
    echo ""
    echo "Intermediate files saved in: $OUTPUT_DIR"
    ls -la $OUTPUT_DIR/
    
else
    echo "=========================================="
    echo "✗ PageRank computation failed!"
    echo "Check error file: project2_pagerank_${SLURM_JOB_ID}.err"
    echo "=========================================="
fi

echo "=========================================="
echo "Job completed at: $(date)"
echo "=========================================="