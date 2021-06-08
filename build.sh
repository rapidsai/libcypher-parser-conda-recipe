#!/bin/bash
# Copyright (c) 2021, NVIDIA CORPORATION.

set -xe

export PATH=/conda/bin:/usr/local/cuda/bin:$PATH
export HOME=$WORKSPACE

source activate base

ARCH=$(uname -m)
if [ "${ARCH}" = "x86_64" ]; then
  ARCH_DIR="linux-64"
elif [ "${ARCH}" = "aarch64" ]; then
  ARCH_DIR="linux-aarch64"
else
  echo "ERROR: Unsupported arch: ${ARCH}"
  exit 1
fi

conda config --set ssl_verify false
conda install -k conda-build conda-verify anaconda-client

conda build -c conda-forge recipe

anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-gpuci} --label thirdparty --label main /opt/conda/conda-bld/${ARCH_DIR}/libcypher-parser*.tar.bz2
