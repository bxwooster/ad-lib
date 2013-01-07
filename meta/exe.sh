#!/bin/bash
shopt -s nullglob
set -e -u -x

$cc \
  -o $exe \
  $source_c \
  -std=c99 \
  -Wall \
  -Wextra \
  -pedantic \
  -Wno-missing-field-initializers \
  -Wno-missing-braces \
  $optimization \
  $link_flags \
  $prefixed_defines \
  -I.config/$platform/include \
  -Icode \
  -Icode/$features \
  -I. \
  -g \

