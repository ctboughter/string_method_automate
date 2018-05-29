# Init_equil directory instructions

Alright so in this directory you're supposed to have some equilibrated simulation (if using CHARMM-GUI,
this should be the step4_equilibration file). After this initial equilibration, you colvar restraints
should be set up (see tutorials on http://www.ks.uiuc.edu/ for how these should be set up,Gumbart, Roux,
& Chipot JCTC 2013, or Donghyuk Suh et. al. 2018 (in preparation))

Once colvars are set up, run a simulation with the force constants set to 0! Run for anywhere from 100000
to 500000 steps (depending on how equilibrated you think your system is). Compare to the example simulation
output files that I have included in this directory.

Lastly, call ./newcenters_average.sh 0  (which then also calls average_colvars.py to get out an avg.0.dat file.
These will be your new centers for each colvar, and force constants should be set to 0.1 for angles, 10 for the
distance colvar, and 1 for the pin colvar. See example_outputs for how the outputs should look

IMPORTANT: scripts are currently hard coded (not great I know) to take out the important colvars data in
the hydrate.0.colvars.traj file. If possible, keep your restraints in the same order.

TO SUM IT ALL UP: Equilibrate your structure and run a short simulation with colvars set up but NOT
applying a force to get the starting structures and colvar variables for generating the string.