#!/bin/bash

if [ -f ./tc_parameters.sh ]; then
    . ./tc_parameters.sh
fi

top_dir=$(pwd)
smb4_minimal_dir=${top_dir}/smb4_minimal_dir
smb4_full_dir=${top_dir}/smb_bin
INSTALL_PREFIX=/${SAMBA_PREFIX}

filename='liblist_full.config'

mkdir -p ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/etc
mkdir -p ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/lib/private
mkdir -p ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/private
mkdir -p ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/var/cache/lck
mkdir -p ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/var/lock

cp -Rvp ${smb4_full_dir}${INSTALL_PREFIX}/smb4/sbin ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4

while read line; do
    cp ${smb4_full_dir}${INSTALL_PREFIX}/smb4/lib/$line ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/lib/$line
done < $filename

mv ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/lib/private/* ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/lib/
rm -rf ${smb4_minimal_dir}/${INSTALL_PREFIX}/smb4/lib/private

