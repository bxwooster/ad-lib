#!/bin/bash
set -e -u
shopt -s nullglob

$cc \
  -o $exe \
  $source_c \
  -std=c99 \
  -Wall \
  -Wextra \
  $link_flags \
  -D$defines \
  -I.config/$platform/include \
  -I. \
  -g \

