#!/bin/bash

export CMAKE_CONFIG="Release"

EXTRA_CMAKE_ARGS=""
if [[ `uname` == 'Darwin' ]];
then
    EXTRA_CMAKE_ARGS="-DCMAKE_MACOSX_RPATH:BOOL=ON"

    # Workaround lack of `MAP_ANONYMOUS` on macOS
    # xref: https://github.com/WebAssembly/wabt/issues/1620
    export CFLAGS="${CFLAGS} --include "sys/mman.h" -DMAP_ANONYMOUS=MAP_ANON"
    export CXXFLAGS="${CXXFLAGS} --include "sys/mman.h" -DMAP_ANONYMOUS=MAP_ANON"
fi
export EXTRA_CMAKE_ARGS

mkdir "build_${CMAKE_CONFIG}"
pushd "build_${CMAKE_CONFIG}"
cmake -G "Ninja" \
    -DCMAKE_BUILD_TYPE:STRING="${CMAKE_CONFIG}" \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DBUILD_TESTS:BOOL=OFF \
    ${EXTRA_CMAKE_ARGS} \
    "${SRC_DIR}"
ninja
ninja install
popd
