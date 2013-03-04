#!/bin/bash

make F=hotremote P=cosmos || exit 0
make P=federer || exit 0

make P=federer run &
sleep 0.5
make P=cosmos run

