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
out=$2

# R, Alpha, Beta, Gamma, Theta, Phi
awk '{print $6","$7","$8","$9","$10","$11","$12","$13","$14}' input.$inp.colvars.traj > data$inp.out
sed -i -e "/Theta/d" data$inp.out
# Apparently we only need this when not running on midway
#rm data$inp.out-e

# Extract the input data of the run before

grep colvarbias input.$inp.inp | awk -F '{' '{print $2}' | awk -F '}' '{print $1}' > inp$inp.out

# now in to python
# similar to the above $1 and $2, we're funneling those same variable in to
# our python script in a similar manner.
ipython average_colvars.py $inp $out

# Great, now let's add these colvars in to the new input file...
# Load in the new colvars
alpha=$(awk 'FNR == 1 {print}' inp$out.out)
beta=$(awk 'FNR == 2 {print}' inp$out.out)
gamma=$(awk 'FNR == 3 {print}' inp$out.out)
theta=$(awk 'FNR == 4 {print}' inp$out.out)
phi=$(awk 'FNR == 5 {print}' inp$out.out)
dist=$(awk 'FNR == 6 {print}' inp$out.out)
pin=$(awk 'FNR == 7 {print}' inp$out.out)

# Pretty much rebuilding the thing from scratch

echo "set step $out" > input.$out.inp 
head -5 input.$inp.inp | tail -4 >> input.$out.inp
echo "set inputname      input.$inp;" >> input.$out.inp
echo 'binCoordinates     $inputname.coor;' >> input.$out.inp
echo 'binVelocities      $inputname.vel;' >> input.$out.inp
echo 'extendedSystem     $inputname.xsc;' >> input.$out.inp
head -61 input.$inp.inp | tail -52 >> input.$out.inp

grep alpha input.$inp.inp | sed "s/{.*}/{$alpha}/g" >> input.$out.inp
grep beta input.$inp.inp | sed "s/{.*}/{$beta}/g" >> input.$out.inp
grep gamma input.$inp.inp | sed "s/{.*}/{$gamma}/g" >> input.$out.inp
grep theta input.$inp.inp | sed "s/{.*}/{$theta}/g" >> input.$out.inp
grep phi input.$inp.inp | sed "s/{.*}/{$phi}/g" >> input.$out.inp
grep ' dist ' input.$inp.inp | sed "s/{.*}/{$dist}/g" >> input.$out.inp
grep ' Pin ' input.$inp.inp | sed "s/{.*}/{$pin}/g" >> input.$out.inp
echo ' ' >> input.$out.inp
echo 'run 500000' >> input.$out.inp
