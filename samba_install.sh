#!/bin/sh

root_dir=$(pwd)
src_dir=${root_dir}/nc_src
build_dir=${root_dir}/build
install_dir=${root_dir}/ncurses_bin

mkdir ${install_dir}
mkdir ${build_dir}

cd ${root_dir}/build

PATH="${TC_TOOLCHAIN_PATH}:${PATH}"
CC=${TC_TOOLCHAIN_TRIPLET}-gcc  ${src_dir}/configure ${TC_TOOLCHAIN_TRIPLET} --host=x86_64-gnu-linux --target=${TC_TOOLCHAIN_TRIPLET} --with-shared --prefix=${install_dir}

make HOSTCC=gcc CXX=${TC_TOOLCHAIN_TRIPLET}-c++

make install

rm -rf ${build_dir}