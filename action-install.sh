#!/usr/bin/env bash

set -e

cd librime
bash install-plugins.sh \
  hchunhui/librime-lua \
  lotem/librime-octagram \
  rime/librime-predict
cd plugins/lua
git clone https://github.com/hchunhui/librime-lua.git -b thirdparty --depth=1 thirdparty
cd ../../
make deps
cd ../
# skip building librime and opencc-data; use downloaded artifacts
make librime

echo "SQUIRREL_BUNDLED_RECIPES=${SQUIRREL_BUNDLED_RECIPES}"

git submodule update --init plum
# install Rime recipes
rime_dir=plum/output bash plum/rime-install ${SQUIRREL_BUNDLED_RECIPES}
make copy-plum-data
