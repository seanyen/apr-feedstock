#!/bin/sh

set -x

cd "${SRC_DIR}/apr"

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  export ac_cv_file__dev_zero=yes
#  export ac_cv_func_setpgrp_void=
#  export apr_cv_process_shared_works=??
#  export apr_cv_mutex_robust_shared=??
#  export apr_cv_tcp_nodelay_with_cork=??
fi

./configure --prefix="${PREFIX}" --host="${HOST}"
make
make install
