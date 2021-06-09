#!/bin/bash

# git clone --branch v0.6.2 https://github.com/cleishm/libcypher-parser.git
# conda install -c conda-forge autoconf automake libtool
#  - or -
# wget https://github.com/cleishm/libcypher-parser/releases/download/v0.6.2/libcypher-parser-0.6.2.tar.gz


# Build peg (parser generator)
PEG_PARENT_DIR=${SRC_DIR}/peg
PEG_DIR=${PEG_PARENT_DIR}/peg-0.1.18

mkdir -p ${PEG_PARENT_DIR}; cd ${PEG_PARENT_DIR}
wget https://github.com/gpakosz/peg/archive/0.1.18.tar.gz
tar zxf 0.1.18.tar.gz
cd peg-0.1.18

# Fix strip binary path to use conda binutils on arm64
if [ "$(arch)" = "aarch64" ]; then
  sed -i 's/strip/${STRIP}/g' Makefile
fi

make ROOT=${PEG_DIR} install

# Build libcypher-parser
cd ${SRC_DIR}
if [ -f ./autogen.sh ]; then
    ./autogen.sh
fi
export LEG=${PEG_DIR}/usr/local/bin/leg
./configure --with-pic --prefix=${PREFIX}
make install
