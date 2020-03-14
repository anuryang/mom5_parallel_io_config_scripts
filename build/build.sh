module purge
module load pbs


# gadi modules
module load hdf5/1.10.5p
module load pnetcdf/1.11.2
module load netcdf/4.7.1p
module load intel-compiler/2019.5.281
module load openmpi/4.0.2

#raijin modules
#module load hdf5/1.10.2p
#module load pnetcdf/1.9.0
#module load netcdf/4.6.1p
#module load openmpi/1.10.0
#module load intel-fc/2018.1.163
#module load intel-cc/2018.1.163

./MOM_compile.csh --platform nci.ncpar --type MOM_SIS --use netcdf4
