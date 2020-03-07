#!/bin/bash
#PBS -P fp0
#PBS -q express
#PBS -l walltime=5:00:00
#PBS -l ncpus=720
#PBS -l mem=2800GB
#PBS -l other=hyperthread
#PBS -l wd
#PBS -N ntv_sca_allrdc

# Runtime modules


module purge
module load pbs
module use /projects/v45/modules
module use /apps/Modules/restricted-modulefiles/hpc-opt
module load hdf5/1.10.2/ompi_1.10.0_itl_15.0.1
module load pnetcdf/1.9.0/ompi_1.10.0_itl_15.0.1
module load netcdf/4.6.1/hdf5_1.10.2_pnetcdf_1.9.0_ompi_1.10.0_itl_15.0.1
module load intel-cc/15.0.1.133
module load openmpi/1.10.0
module load intel-fc/15.0.1.133



#module purge
#module load pbs
#module use /projects/v45/modules
#module load hdf5/1.10.2p
#module load openmpi/3.0.1
#module load netcdf/4.6.1p
#module load intel-fc/2018.1.163
#module load intel-cc/2018.1.163


#source /home/900/rxy900/.bashrc
#module purge
#module load pbs
#module use /apps/Modules/restricted-modulefiles/hpc-opt
#module load hdf5/1.10.2/ompi_1.10.0_itl_15.0.1
#module load pnetcdf/1.9.0/ompi_1.10.0_itl_15.0.1
#module load netcdf/4.6.1/hdf5_1.10.2_pnetcdf_1.9.0_ompi_1.10.0_itl_15.0.1 
#module load openmpi/1.10.0                                                  

#source /home/900/rxy900/.bashrc
#module purge
#module load pbs
#module use /apps/Modules/restricted-modulefiles/hpc-opt
#module load hdf5/1.10.4/ompi_3.1.3_itl_2019.0.117
#module load pnetcdf/1.10.0/ompi_3.1.3_itl_2019.0.117
#module load netcdf/4.6.2/hdf5_1.10.4_pnetcdf_1.10.0_ompi_3.1.3_itl_2019.0.117
#module load intel-cc/2019.0.117
#module load openmpi/3.1.3
#module load intel-fc/2019.0.117


cd ${PBS_O_WORKDIR}
#for lib in nc4
for lib in  nc4  nc_classic
do 
#    for nc_blksz in 65536 524288 1048576 8388608 16777216 33554432 67108864
    for nc_blksz in 65536
    do
	for stp_size in 1048576
	do 
	    for stp_cnt in  45
	    do 
		for cbnode in  1440
		do 
		    for irun in 1 2 3 
		    do
			rm input.nml
			rm ocean.nc
			cp input.nml.${lib} input.nml
#			rm -rf INPUT
#			mkdir INPUT
#			lfs setstripe -s ${stp_size}  -c ${stp_cnt} INPUT 
#			cp /short/fp0/rxy900/MOM_9_may_2018/sis/INPUT/* ./INPUT
			rm -rf RESTART
			mkdir RESTART		    
#		    export cb_buffer_size_RD=33554432
		    
			export cb_nodes_WR=$cbnode
			export cb_nodes_RD=$cbnode
			
			export cb_buffer_size_WR=$nc_blksz
			export cb_buffer_size_RD=$nc_blksz
			
			export striping_factor_WR=$stp_cnt
			export striping_unit_WR=$stp_size
			
			export cb_config_list_WR="*:1"
			export cb_config_list_RD="*:1"

			mpirun ./fms_MOM_SIS.x > output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log
			ls -lh ocean.nc >> output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log
			lfs getstripe ocean.nc >> output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log
			ncdump -sh ocean.nc >> output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log
			lfs getstripe RESTART/* >> output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log
			rm ocean.nc
		        rm -rf RESTART
		    done
		done
	    done
	done
    done
done



