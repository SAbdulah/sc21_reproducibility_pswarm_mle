module switch PrgEnv-cray PrgEnv-gnu
module load cmake
export LC_ALL=en_US.UTF-8
export CRAYPE_LINK_TYPE=dynamic
module load boost/1.66-gcc-8.3.0

#Intel MKL:
#==========
==================================================
mkdir codes
cd codes
export SETUP_DIR=$PWD
if [ ! -d "nlopt-2.4.2" ]; then
        wget http://ab-initio.mit.edu/nlopt/nlopt-2.4.2.tar.gz
        tar -zxvf nlopt-2.4.2.tar.gz
fi
cd nlopt-2.4.2
[[ -d nlopt_install ]] || mkdir nlopt_install
CC=gcc ./configure  --prefix=$PWD/nlopt_install/ --enable-shared --without-guile
make -j
make -j install
export NLOPTROOT=$PWD
export PKG_CONFIG_PATH=$NLOPTROOT/nlopt_install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$NLOPTROOT/nlopt_install/lib:$LD_LIBRARY_PATH
#================================
cd $SETUP_DIR
if [ ! -d "gsl-2.4" ]; then
        wget https://ftp.gnu.org/gnu/gsl/gsl-2.4.tar.gz
        tar -zxvf gsl-2.4.tar.gz
fi
cd gsl-2.4
[[ -d gsl_install ]] || mkdir gsl_install
CC=gcc ./configure  --prefix=$PWD/gsl_install/
make -j
make -j install
GSLROOT=$PWD
export PKG_CONFIG_PATH=$GSLROOT/gsl_install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$GSLROOT/gsl_install/lib:$LD_LIBRARY_PATH
================================
cd $SETUP_DIR
cp ../hwloc-1.11.5.tar.gz ./
if [  ! -d "hwloc-1.11.5" ]; then
        tar -zxvf hwloc-1.11.5.tar.gz
fi
cd hwloc-1.11.5
[[ -d hwloc_install ]] || mkdir hwloc_install
CC=cc CXX=CC ./configure  --prefix=$PWD/hwloc_install --disable-libxml2 -disable-pci --enable-shared=yes

make -j
make -j install
export HWLOCROOT=$PWD
export PKG_CONFIG_PATH=$HWLOCROOT/hwloc_install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$HWLOCROOT/hwloc_install/lib:$LD_LIBRARY_PATH
================================
cd $SETUP_DIR
if [ ! -d "starpu-1.2.8" ]; then
        wget http://starpu.gforge.inria.fr/files/starpu-1.2.8/starpu-1.2.8.tar.gz
        tar -zxvf starpu-1.2.8.tar.gz
fi
cd starpu-1.2.8
#CFLAGS=-fPIC CXXFLAGS=-fPIC 
CC=cc CXX=CC FC=ftn ./configure  --prefix=$PWD/starpu_install/ --disable-cuda --disable-opencl --enable-shared --disable-build-doc --disable-export-dynamic --disable-mpi-check  --with-mpicc=/opt/cray/pe/craype/2.6.3/bin/cc
make -j
make -j  install
export STARPUROOT=$PWD
export PKG_CONFIG_PATH=$STARPUROOT/starpu_install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$STARPUROOT/starpu_install/lib:$LD_LIBRARY_PATH
export CPATH=$STARPUROOT/starpu_install/include:$CPATH
export CPATH=$STARPUROOT/starpu_install/include/starpu/1.2:$CPATH
#************************************************************************ Install Chameleon - Stars-H - HiCMA
module load intel

## CHAMELEON
cd $SETUP_DIR
cp ../chameleon.tar.gz ./
tar -zxvf chameleon.tar.gz
mv chameleon-xcsystem chameleon
cd chameleon
export CHAMELEONDIR=$PWD
rm -rf build
mkdir -p build/install_dir
cd build


LDFLAGS=-lrt cmake ..  -DCMAKE_CXX_COMPILER=CC -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_FLAGS='-g' -DCMAKE_C_FLAGS='-g' -DCMAKE_Fortran_COMPILER=ftn -DCMAKE_INSTALL_PREFIX=$PWD/install_dir -DCMAKE_COLOR_MAKEFILE:BOOL=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DBUILD_SHARED_LIBS=ON -DCHAMELEON_ENABLE_EXAMPLE=ON -DCHAMELEON_ENABLE_TESTING=ON -DCHAMELEON_ENABLE_TIMING=ON -DCHAMELEON_USE_MPI=ON -DCHAMELEON_USE_CUDA=OFF -DCHAMELEON_USE_MAGMA=OFF -DCHAMELEON_SCHED_QUARK=OFF -DCHAMELEON_SCHED_STARPU=ON -DCHAMELEON_USE_FXT=OFF -DSTARPU_DIR=$STARPUROOT/starpu_install -DBLAS_LIBRARIES="-Wl,--no-as-needed;-L${MKLROOT}/lib;-lmkl_intel_lp64;-lmkl_core;-lmkl_sequential;-lpthread;-lm;-ldl" -DBLAS_COMPILER_FLAGS="-m64;-I${MKLROOT}/include" -DLAPACK_LIBRARIES="-Wl,--no-as-needed;-L${MKLROOT}/lib;-lmkl_intel_lp64;-lmkl_core;-lmkl_sequential;-lpthread;-lm;-ldl" -DCBLAS_DIR="${MKLROOT}" -DLAPACKE_DIR="${MKLROOT}" -DTMG_DIR="${MKLROOT}" -DMORSE_VERBOSE_FIND_PACKAGE=ON -DMPI_C_COMPILER=/opt/cray/pe/craype/2.6.3/bin/cc -DBUILD_SHARED_LIBS=ON 


make -j # CHAMELEON parallel build seems to be fixed
make install

export PKG_CONFIG_PATH=$CHAMELEONDIR/build/install_dir/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$CHAMELEONDIR/build/install_dir/lib/:$LD_LIBRARY_PATH
export CPATH=$CHAMELEONDIR/build/install_dir/include/coreblas:$CPATH
export PATH=$CHAMELEONDIR/build/install_dir/include/coreblas:$PATH



#PPSwarm_v1_5
cd $SETUP_DIR
cp ../PPSwarm_v1_5.tar.gz ./
tar -zxvf PPSwarm_v1_5.tar.gz
cd PPSwarm_v1_5
export PPSWARMDIR=$PWD
make parallel
export CPATH=$PPSWARMDIR/include:$PPSWARMDIR:$CPATH
export LD_LIBRARY_PATH=$PPSWARMDIR/libs:$LD_LIBRARY_PATH


#ExaGeoStat
cd $SETUP_DIR
cd ..
tar -zxvf exageostat-spacetime.tar.gz
cd exageostat-spacetime
export EXAGEOSTATDIR=$PWD
rm -rf build
mkdir -p build/install_dir
cd build


cmake ..  -DCMAKE_CXX_COMPILER=CC -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_FLAGS='-g' -DCMAKE_Fortran_COMPILER=ftn -DCMAKE_INSTALL_PREFIX=$PWD/install_dir -DEXAGEOSTAT_USE_MPI=1 -DCMAKE_COLOR_MAKEFILE:BOOL=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DBUILD_SHARED_LIBS=ON  -DSTARPU_DIR=$STARPUROOT/starpu_install -DMPI_C_COMPILER=/opt/cray/pe/craype/2.6.3/bin/cc -DEXAGEOSTAT_USE_HICMA=OFF -DEXAGEOSTAT_USE_NETCDF=OFF -DLAPACKE_INCLUDE_DIRS="-m64;-I${MKLROOT}/include"  -DBLAS_LIBRARIES="-Wl,--no-as-needed;-L${MKLROOT}/lib;-lmkl_intel_lp64;-lmkl_core; -lmkl_sequential;-lpthread;-lm;-ldl" -DBLAS_COMPILER_FLAGS="-m64;-I${MKLROOT}/include" -DLAPACK_LIBRARIES="-Wl,--no-as-needed;-L${MKLROOT}/lib;-lmkl_intel_lp64;-lmkl_core; -lmkl_sequential;-lpthread; -lm;-ldl" -DCBLAS_DIR="${MKLROOT}" -DLAPACKE_DIR="${MKLROOT}" -DTMG_DIR="${MKLROOT}"

make -j 
make install

