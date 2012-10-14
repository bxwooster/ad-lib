#!/bin/bash
set -e -u
shopt -s nullglob

$cc \
  -o $exe \
  $source_c \
  -std=gnu99 \
  -Wall \
  -Wextra \
  $link_flags \
  -I.config/$platform/include \
  -I. \
  -g \

