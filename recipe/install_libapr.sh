#!/bin/sh

set -x

cd "${SRC_DIR}/apr"

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" && $target_platform == "osx-arm64" ]]; then
  export ac_cv_file__dev_zero=yes
  export ac_cv_func_setpgrp_void=yes
  export apr_cv_process_shared_works=yes
  export apr_cv_mutex_robust_shared=no
  export apr_cv_tcp_nodelay_with_cork=no
  export ac_cv_sizeof_struct_iovec=16
fi

autoreconf -vfi

./configure --prefix="${PREFIX}" --host="${HOST}"

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  (
    mkdir -p native-build/bin
    pushd native-build/bin

    # MACOSX_DEPLOYMENT_TARGET is for the target_platform and not for build_platform
    unset MACOSX_DEPLOYMENT_TARGET

    $CC_FOR_BUILD ../../tools/gen_test_char.c -o gen_test_char

    popd
  )
  export PATH=`pwd`/native-build/bin:$PATH
fi

make
make install
