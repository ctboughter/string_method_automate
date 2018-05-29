#!/bin/bash

# Let's make our input files for running this
# fun stuff...

for i in {60..70}
do
    echo "set step $i" > hydrate.$i.inp
    echo "set temp      300.15" >> hydrate.$i.inp
    echo "structure             ../step3_pbcsetup.xplor.ext.psf" >> hydrate.$i.inp
    echo "coordinates           ../step3_pbcsetup.pdb" >> hydrate.$i.inp
    echo "set inputname      step4_equilibration;" >> hydrate.$i.inp
    echo 'binCoordinates     $inputname.coor;' >> hydrate.$i.inp
    echo 'binVelocities      $inputname.vel;' >> hydrate.$i.inp
    echo 'extendedSystem     $inputname.xsc;' >> hydrate.$i.inp
    echo " " >> hydrate.$i.inp
    echo 'outputname            hydrate.$step;' >> hydrate.$i.inp
    tail -85 hydrate.inp | head -78 >> hydrate.$i.inp

    mv hydrate.$i.inp coor$i/namd/.
    cd coor$i/namd/
    tail -8 input.$i.inp | head -6 >> hydrate.$i.inp
    #x=$(echo "0.25*$i+21.069" | bc )
    z=$(($i-59))
    x=$(echo "0.5*$z+35.819" | bc )
    echo 'colvarbias changeconfig Pin "centers {FUCK}   forceconstant 1.0"' >> hydrate.$i.inp
    echo " " >> hydrate.$i.inp
    echo "run 2500000" >> hydrate.$i.inp
    sed -i "s/FUCK/$x/g" hydrate.$i.inp
    cd ../../
done
