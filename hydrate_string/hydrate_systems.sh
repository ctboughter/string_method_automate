#!/bin/bash

# So this script is hopefully going to set up all 75 different directories for
# hydrating the proper path towards a good hydrated string.

# We'll want to run the CHARMM hydration setup for every single one.

# THEN, we'll actually run 2-4ns of each one... Should take a lot of SUs

for i in {0..75};
do
    mkdir coor$i
    cp ../vac_AVG_improve2/input.$i.dcd coor$i/.
    cp ../hydrate_RouxMethod/test_newParams/vac_protein* coor$i/.
    cp ../hydrate_RouxMethod/test_newParams/*inp coor$i/.
    cp ../hydrate_RouxMethod/test_newParams/toppar.str coor$i/.
    cp -r ../hydrate_RouxMethod/test_newParams/toppar coor$i/.
    cp ../hydrate_RouxMethod/test_newParams/crystal_image.str coor$i/.
    cp ../hydrate_RouxMethod/test_newParams/checkfft.py coor$i/.
done

