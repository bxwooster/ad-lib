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
  -Werror \
  $optimization \
  $link_flags \
  -D$defines \
  -I.config/$platform/include \
  -Icode \
  -Icode/$features \
  -I. \
  -g \

