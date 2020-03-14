#!/bin/bash
#PBS -P fp0
#PBS -q normal
#PBS -l walltime=5:00:00
#PBS -l ncpus=1440
#PBS -l mem=5600GB
#PBS -l other=hyperthread
#PBS -l wd
#PBS -N ntv_sca_allrdc

# Runtime modules

#gadi modules
module load hdf5/1.10.5p
module load pnetcdf/1.11.2
module load netcdf/4.7.1p
module load openmpi/4.0.2


#raijin modules
#module load hdf5/1.10.2
#module load pnetcdf/1.9.0
#module load netcdf/4.6.1
#module load openmpi/1.10.0

cd ${PBS_O_WORKDIR}

for lib in  nc4 nc_classic serial
do 
    for nc_blksz in 65536
    do
	for stp_size in 1048576
	do 
	    for stp_cnt in  90
	    do 
		for cbnode in  1440
		do 
		    for irun in 1
		    do
			cp input.nml.${lib} input.nml
			export cb_nodes_WR=$cbnode
			export cb_nodes_RD=$cbnode
			
			export cb_buffer_size_WR=$nc_blksz
			export cb_buffer_size_RD=$nc_blksz
			
			export striping_factor_WR=$stp_cnt
			export striping_unit_WR=$stp_size
			
			export cb_config_list_WR="*:1"
			export cb_config_list_RD="*:1"

			mpirun ./fms_MOM_SIS.x > output.nc_blksz_${nc_blksz}.stp_cnt_${stp_cnt}.stp_size_${stp_size}.cb_node_${cbnode}_${irun}.${lib}.log

		    done
		done
	    done
	done
    done
done



