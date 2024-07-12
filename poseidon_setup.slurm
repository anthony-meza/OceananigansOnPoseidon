#!/bin/bash
#SBATCH --job-name=myjob         # create a short name for your job
#SBATCH --partition=gpu        # put the job into the gpu partition
#SBATCH --gres=gpu:1
#SBATCH --nodes=1                # node count
#SBATCH --time=00:20:00          # total run time limit (HH:MM:SS)

module purge
module load julia/1.9.4 #Oceananigans requires julia > 1.9
module load cuda11.2/toolkit/11.2.2
module load cuda11.2/cudnn/8.6.0

echo 'Starting CUDA test!'
JULIA_DEBUG=CUDAapi julia CUDA_test.jl
echo 'Starting Oceananigans test!'
JULIA_DEBUG=CUDAapi julia Oceananigans_test.jl
echo 'Starting ClimaOcean test!'
JULIA_DEBUG=CUDAapi julia ClimaOcean_test.jl
