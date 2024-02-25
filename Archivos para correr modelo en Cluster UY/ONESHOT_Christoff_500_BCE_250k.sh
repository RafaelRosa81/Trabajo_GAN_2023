#!/bin/bash
#SBATCH --job-name=Christoff_500_BCE
#SBATCH --ntasks=1
#SBATCH --mem=12G
#SBATCH --time=120:00:00
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
python train.py --exp_name Christoff_500_BCE --dataset_name ChristoffJPG_nomask --num_epochs 250000 --max_size 500 --use_kornia_augm --prob_augm 0.7 --no_masks --batch_size 5

#TEST
python test.py --exp_name Christoff_500_BCE --which_epoch 20000
python test.py --exp_name Christoff_500_BCE --which_epoch 50000
python test.py --exp_name Christoff_500_BCE --which_epoch 100000
python test.py --exp_name Christoff_500_BCE --which_epoch 120000
python test.py --exp_name Christoff_500_BCE --which_epoch 150000
python test.py --exp_name Christoff_500_BCE --which_epoch 200000
python test.py --exp_name Christoff_500_BCE --which_epoch 220000
python test.py --exp_name Christoff_500_BCE --which_epoch 250000

'''
##sbatch <mitrabajo.sh> 	Ejecutar un script
##srun --pty <comando> 	Ejecutar un trabajo o comando interactivo
#srun --pty bash -l 	Iniciar una sesión interactiva
##interactivo 	Iniciar una sesión interactiva con diversas opciones

Información de trabajos
Comando 	Descripción
##squeue 	Ver todos los trabajos
##squeue -u <usuario> 	Ver todos los trabajos de un usuario
##squeue -u <usuario> -t RUNNING 	Ver todos los trabajos en ejecución de un usuario
##squeue -u <usuario> -t PENDING 	Ver todos los trabajos en cola de un usuario
##scontrol show jobid -dd <jobid> 	Ver información detallada de un trabajo
##sacct -j <JobID> --format=User,Job,JobName,CPUTime,Elapsed 	Ver información sobre el uso de recursos de los trabajos finalizados. Muestra usuario, id del trabajo tiempo de ejecución y memoria utilizada
'''

#Para ejecutar un trabajo SBACHT: 
#El trabajo es cargado en el sistema con el comando sbatch miscript.sh

#Para obtener información detallada del trabajo <ID>:
###$ scontrol show job <ID>

#Para cancelar la ejecución del trabajo <ID>:
###scancel <ID>

