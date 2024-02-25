#!/bin/bash
#SBATCH --job-name=AA_330_WGAN
#SBATCH --ntasks=1
#SBATCH --mem=12G
#SBATCH --time=100:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rafael.rosa.uy@gmail.com

#SBATCH --gres=gpu:p100:1

#SBATCH --partition=normal
#SBATCH --qos=gpu

source miniconda3/etc/profile.d/conda.sh

conda activate buenosmis

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:miniconda3/pkgs/libgcc-ng-9.1.0-hdf63c60_0/lib

cd ~/one-shot-synthesis

#TRAIN
python train.py --exp_name AA_330_WGAN --dataset_name AA_MAX_0039-001_72img_tort57x100 --num_epochs 150000 --max_size 330 --use_kornia_augm --prob_augm 0.7 --no_masks --loss_mode wgan --batch_size 5

#TEST
python test.py --exp_name AA_330_WGAN --which_epoch 20000
python test.py --exp_name AA_330_WGAN --which_epoch 50000
python test.py --exp_name AA_330_WGAN --which_epoch 100000
python test.py --exp_name AA_330_WGAN --which_epoch 130000
python test.py --exp_name AA_330_WGAN --which_epoch 150000

#Para ejecutar un trabajo SBACHT: 
#El trabajo es cargado en el sistema con el comando sbatch miscript.sh

#Para obtener información detallada del trabajo <ID>:
#$ scontrol show job <ID>

#Para cancelar la ejecución del trabajo <ID>:
#scancel <ID>

