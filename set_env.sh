export LC_ALL=en_US.UTF-8
export CRAYPE_LINK_TYPE=dynamic
module switch PrgEnv-cray PrgEnv-gnu
module load boost/1.66-gcc-8.3.0
module load intel


export PKG_CONFIG_PATH=$SETUP_DIR/hwloc-1.11.8/hwloc_install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$SETUP_DIR/hwloc-1.11.8/hwloc_install/lib:$LD_LIBRARY_PATH

export PKG_CONFIG_PATH=$SETUP_DIR/exageostatr/src/hicma/build/install_dir/lib/pkgconfig:$SETUP_DIR/exageostatr/src/hicma/chameleon/build/install_dir/lib/pkgconfig:$SETUP_DIR/exageostatr/src/stars-h/build/install_dir/lib/pkgconfig:$SETUP_DIR/starpu-1.2.8/starpu_install/lib/pkgconfig:$SETUP_DIR/nlopt-2.4.2/nlopt_install/lib/pkgconfig:$SETUP_DIR/gsl-2.4/gsl_install/lib/pkgconfig:$PKG_CONFIG_PATH

export CPATH=$SETUP_DIR/exageostatr/src/hicma/chameleon/build/install_dir/include/coreblas:$SETUP_DIR/starpu-1.2.8/starpu_install/include/starpu/1.2/:$SETUP_DIR/gsl-2.4/gsl_install/include:$SETUP_DIR/exageostatr/src/hicma/build/install_dir/include::$SETUP_DIR/nlopt-2.4.2/nlopt_install/include:/project/k1200/sameh/codes/pagmo2/build/install_dir/include:$CPATH


export PATH=$SETUP_DIR/exageostatr/src/hicma/chameleon/build/install_dir/include/coreblas:$SETUP_DIR/starpu-1.2.8/starpu_install/include/starpu/1.2/:$SETUP_DIR/gsl-2.4/gsl_install/include:$PATH

export LD_LIBRARY_PATH=$SETUP_DIR/exageostatr/src/hicma/build/install_dir/lib/:$SETUP_DIR/exageostatr/src/hicma/chameleon/build/install_dir/lib/:$SETUP_DIR/exageostatr/src/stars-h/build/install_dir/lib/pkgconfig:$SETUP_DIR/starpu-1.2.8/starpu_install/lib:$SETUP_DIR/nlopt-2.4.2/nlopt_install/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=$SETUP_DIR/gsl-2.4/gsl_install/lib:$LD_LIBRARY_PATH

export CPATH=$SETUP_DIR/PPSwarm_v1_5/include:/project/k1200/sameh/codes/PPSwarm_v1_5:$CPATH
export LD_LIBRARY_PATH=$SETUP_DIR/PPSwarm_v1_5/libs:$LD_LIBRARY_PATH
