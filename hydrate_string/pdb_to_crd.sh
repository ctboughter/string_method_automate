#!/bin/bash

# Should have run dcd_to_pdb first in VMD.
# Now need to make those PDBs CHARMM-readable,
# Then you can send this stuff right in to the 

for i in {0..75}
do
    
    grep " PROA " coor$i/coor$i.pdb > coor$i/a$i.pdb
    grep " PROB " coor$i/coor$i.pdb > coor$i/b$i.pdb

    echo TER >> coor$i/a$i.pdb
    echo END >> coor$i/a$i.pdb
    echo TER >> coor$i/b$i.pdb
    echo END >> coor$i/b$i.pdb

    sed -i 's/HIS/HSD/g' coor$i/a$i.pdb
    sed -i 's/HIS/HSD/g' coor$i/b$i.pdb

    sed -i 's/                 /            PROA /g' coor$i/a$i.pdb
    sed -i 's/                 /            PROB /g' coor$i/b$i.pdb
done
