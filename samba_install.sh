top_dir=$(pwd)
cd ./smb_src

PATH="${TC_TOOLCHAIN_PATH}:${PATH}"
QEMU_PATH_ENV=${C_TOOLCHAIN_DIR}
CROSS_COMPILE=${C_TOOLCHAIN_UTILITES_HOST}-
python_ROOT_DIR_EMB=${top_dir}/python_bin/
NCURSES_CONFIG_EMB=${top_dir}/ncurses_bin/
DESTDIR_ENV=${top_dir}/smb_bin
export QEMU_PATH_ENV
export CROSS_COMPILE
export python_ROOT_DIR_EMB
export NCURSES_CONFIG_EMB
export DESTDIR_ENV

make configure_embedded
make build_embedded
make install_embedded