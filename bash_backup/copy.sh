#!/bin/bash
#PBS -A engin_flux
#PBS -M unghee@umich.edu
#PBS -m abe
#PBS -V
#PBS -N Ra_Reitz
#PBS -l walltime=00:01:00,pmem=2500mb,procs=1
#PBS -l qos=flux
#PBS -q flux
#PBS -joe

#cd $PBS_O_WORKDIR
#cd Ra_Reitz
# afterwards do it as a loop i=1:10 v{i}..
#cd afteroptimize_test_40atm_phi1
dir=$(pwd)
cd $dir
echo $dir

for((i=1;i<=25;i++))
	do
		mkdir id_$i
		cd id_$i
		
		cp ../ck_$i/CKSoln_solution_point_value_vs_solution_number.csv ./
		cp ../ck_$i/*.inp ./
		cp ../ck_$i/*.out ./
		cp ../ck_$i/XMLdata.zip ./
		cp ../ck_$i/chem.asc ./
		cp ../ck_$i/chemkindata.dtd ./
		cd ..

		rm -rf ck_$i
done
