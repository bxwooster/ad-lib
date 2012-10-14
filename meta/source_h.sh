#!/bin/bash
set -e -u
shopt -s nullglob

rm -f $source_h.tmp
for feature in . $features; do
  for file in `echo code/$feature/*.c`;
  do
    awk 'BEGIN{RS="{"} {print $$0,";"; exit}' \
      $file >> $source_h.tmp
  done ;
done ;
mv $source_h.tmp $source_h

