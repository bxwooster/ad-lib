#!/bin/bash
set -e -u

cp meta/$program.ext.h $source_ext_h.tmp
for include in $includes; do
  echo "#include <$include>" >> $source_ext_h.tmp
done ;
mv $source_ext_h.tmp $source_ext_h

