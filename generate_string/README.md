# generate_string directory instructions

Alright so if you're in here, make sure that you start off with init_vacuum first. That input file
is a little different from the one that we're going to iterating through the entire string, so we want
it all alone... Once that's done running though, move all outputs in to THIS directory.

We're acting as if I already did that and ALSO ran the input.1.inp (which you should know how to do by now)
input.1.inp again has the colvars manually added in there from avg.0.out (don't worry, it'll automate from there)

THEN it should be automated! In this same directory, you want to run make_newcenter.sh on these input.1 outputs.
call ./make_newcenter.sh 1 2
This should output a good bit of stuff (all in the example_outputs directory) BUT the most important is input.2.inp
Now this script is still a little finicky, so you really need to compare input.1.inp and input.2.inp. The best way to
do this is simply call:
diff input.1.inp input.2.inp
wc -l input.1.inp
wc -l input.2.inp

Obviously the line counts should match up, and the differences between 1 and 2 should only be in the colvars.
Once this is done, you should be able to run in to the production version of this script: simply submit dyn.csh
to some hpc cluster (the file here is set up for midway at the University of Chicago)

Assuming your job doesn't die, you should successfully have generated your first ever string! Congrats!