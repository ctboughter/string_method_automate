#!/bin/sh

##### Chris Boughter 12/12/17 #######
# Need to make a script that determines the new angles
# (phi, psi, theta, phi_low, theta_low) for colvars
# in the initial generation of the string.

# Can use averages of each of these values, which
# conceptually shouldn't change things from using DHAM.
# Unlike DHAM, these need to be iterated one by one.

# Was going to do this in bash, but it's probably way faster to just do it in python...
#NVM do it partially in bash. Get rid of all of the strings...
# Here the $1 and $2 refer to the variables that are specified
# when the command is called (see dyn.csh file for what inputs are)
module load python

inp=$1

#cd coor$inp/namd

# Pin Alpha, Beta, Gamma, Theta, Phi, R
awk '{print $6","$9","$10","$11","$12","$13","$14}' input.$inp.colvars.traj > data.$inp.out
sed -i -e "/Theta/d" data.$inp.out
# Apparently we only need this when not running on midway
#rm data$inp.out-e

# Extract the input data of the run before

grep colvarbias input.$inp.inp | awk -F '{' '{print $2}' | awk -F '}' '{print $1}' > inp.$inp.out

# now in to python
# similar to the above $1 and $2, we're funneling those same variable in to
# our python script in a similar manner.
ipython average_colvars.py $inp

