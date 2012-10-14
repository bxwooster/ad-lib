#!/bin/bash
set -e -u

false #disabled at the moment
cp -r \
  $exe \
  data \
  $package_dir \
# art ? \
# dlls ? \

tar -cj $package_dir -f $package_archive

