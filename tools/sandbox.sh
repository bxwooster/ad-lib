#!/bin/bash

make program=cosmos || exit 0
make program=federer || exit 0

make program=federer run &
sleep 0.2
make program=cosmos run

