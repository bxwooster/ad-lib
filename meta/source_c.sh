#!/bin/bash
set -e -u
shopt -s nullglob

rm -f $source_c.tmp
echo "#include <$source_ext_h>" >> $source_c.tmp
for feature in . $features; do
  for file in `echo code/$feature/*.h`;
  do
    echo "#include <$file>" >> $source_c.tmp ;
  done ;
done
echo "#include <$source_h>" >> $source_c.tmp
for feature in . $features; do
  for file in `echo code/$feature/*.c`;
  do
    echo "#include <$file>" >> $source_c.tmp ;
  done ;
done
mv $source_c.tmp $source_c

