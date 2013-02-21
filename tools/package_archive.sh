#!/bin/bash
set -e -u

cp -r \
  $exe \
  data \
  mode \
  art \
  .config/$platform/package/* \
  $package_dir \

tar -cj $package_dir -f $package_archive

