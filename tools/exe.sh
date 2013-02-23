#!/bin/bash
shopt -s nullglob
set -e -u -x

$cc \
  -o $exe \
  $all_source \
  -std=c99 \
  -Wall \
  -Wextra \
  -pedantic \
  -Wno-missing-field-initializers \
  -Wno-missing-braces \
  -I.config/$platform/include \
  -L.config/$platform/lib \
  $include_flags \
  $optimization \
  $link_flags \
  $prefixed_defines \
  -g \

