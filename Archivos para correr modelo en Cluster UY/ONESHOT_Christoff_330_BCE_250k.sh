#!/bin/bash
#SBATCH --job-name=Christoff_330_BCE
#SBATCH --ntasks=1
#SBATCH --mem=12G
#SBATCH --time=48:00:00
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
python train.py --exp_name Christoff_330_BCE --dataset_name ChristoffJPG_nomask --num_epochs 250000 --max_size 330 --use_kornia_augm --prob_augm 0.7 --no_masks --batch_size 5

#TEST
python test.py --exp_name Christoff_330_BCE --which_epoch 20000
python test.py --exp_name Christoff_330_BCE --which_epoch 50000
python test.py --exp_name Christoff_330_BCE --which_epoch 100000
python test.py --exp_name Christoff_330_BCE --which_epoch 130000
python test.py --exp_name Christoff_330_BCE --which_epoch 150000
python test.py --exp_name Christoff_330_BCE --which_epoch 200000
python test.py --exp_name Christoff_330_BCE --which_epoch 220000
python test.py --exp_name Christoff_330_BCE --which_epoch 250000
