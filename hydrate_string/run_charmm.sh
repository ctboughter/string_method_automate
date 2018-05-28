#!/bin/sh
#SBATCH --job-name=hydrate
#SBATCH --output=hydrate.out
#SBATCH --account=legacy
#SBATCH --partition=sandyb
#SBATCH --qos=normal
#SBATCH --exclusive
#SBATCH --nodes=1
#SBATCH --time=20:00:00
# So here, we try to solvate every single one of our fun little systems.
# Should have already run all the other scripts (see the README file)

# Let's run the usual CHARMM routine!

# NOTE: EVERYTHING gets messed up if any systems have
# LESS water than the coor0 file... issue? We'll see

for i in {0..75}
do
    cd coor$i

    /project/roux/hrui/package/charmm/c40a1_em64t < alt_step1_pdbreader.inp > step1.out

    /project/roux/hrui/package/charmm/c40a1_em64t < step2.1_waterbox.inp > step2.1.out

    /project/roux/hrui/package/charmm/c40a1_em64t < alt_step2.2_ions.inp > step2.2.out

    /project/roux/hrui/package/charmm/c40a1_em64t < alt_step2_solvator.inp > step2.out

    /project/roux/hrui/package/charmm/c40a1_em64t < step3_pbcsetup.inp > step3.1.out

    /project/roux/hrui/package/charmm/c40a1_em64t < step3_input.inp > step3.2.out

    cd ..

done

