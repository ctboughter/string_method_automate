#!/bin/bash

# So we need to edit the charmm input scripts such
# that they run the exact same for all of these systems.

# If I'm not mistaken, we should really only need to edit 1...

for i in {0..75}
do 
    sed -i "s/a75.pdb/a$i.pdb/g" coor$i/alt_step1_pdbreader.inp
    sed -i "s/b75.pdb/b$i.pdb/g" coor$i/alt_step1_pdbreader.inp
done
