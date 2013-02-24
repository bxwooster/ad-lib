#!/bin/bash

make program=nadal || exit 0
make program=federer || exit 0

make program=federer run &
sleep 0.5
make program=nadal run

