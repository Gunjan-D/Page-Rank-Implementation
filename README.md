<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> SeaWulf HPC PageRank (MPI + MapReduce) </title>
</head>
<body>
# 🎯 SeaWulf HPC PageRank (MPI + MapReduce)

[![SeaWulf Cluster](https://img.shields.io/badge/Platform-SeaWulf-blue)](https://www.hpc.stonybrook.edu/)
[![MPI4Py](https://img.shields.io/badge/MPI-mpi4py-green)](https://mpi4py.readthedocs.io/)
[![SLURM](https://img.shields.io/badge/Cluster-SLURM-orange)](https://slurm.schedmd.com/)

**Google PageRank implementation** using **MPI4Py + MapReduce** on Stony Brook University's **SeaWulf HPC cluster**. Ranks millions of web links via **taxation method (β=0.9)** in **4 parallel iterations** across **5 nodes**.

## 🎯 Project Overview

Analyzed massive directed web graphs where each row `src,dst` represents `src → dst` hyperlink. **Core challenge**: Scale PageRank computation across distributed cluster nodes while ensuring convergence within fixed iterations.

**Key Results**: Top-10 authoritative pages (ID **1002618**: PageRank **91.96**) saved as `pageranktop10results.txt` + JSON.

## 🛠 Tech Stack & Implementation

