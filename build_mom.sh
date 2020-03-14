git clone https://github.com/mom-ocean/MOM5.git
wget https://github.com/NOAA-GFDL/FMS/archive/parallel_NCDF.zip
unzip parallel_NCDF.zip
rm -rf MOM5/src/shared/*
cp -r FMS-parallel_NCDF/* MOM5/src/shared/
cp -r build/version  MOM5/src/shared/
patch MOM5/src/shared/coupler/atmos_ocean_fluxes.F90  ./build/atmos_ocean_fluxes.patch
cp build/build.sh MOM5/exp
cp build/environs.nci.ncpar MOM5/bin
cp build/mkmf.template.nci.ncpar MOM5/bin
cd MOM5/exp
./build.sh

