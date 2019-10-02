#!/bin/bash

export PATH=/conda/bin:/usr/local/cuda/bin:$PATH
export HOME=$WORKSPACE

source activate gdf

conda build -c conda-forge ./recipe/libcypher-parser

conda build -c conda-forge ./recipe/libcypher-parser --output | xargs \
     anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-rapidsai} --label thirdparty --label main --force
