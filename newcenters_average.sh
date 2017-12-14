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
awk '{print $2","$17","$18","$19","$20","$21}' input.0.colvars.traj > temp
sed -i -e "/step/d" temp
rm temp-e

echo ' ' > data0.out
cat temp >> data0.out
# Extract the input data of the run before
echo ' ' > inp0.out
grep colvarbias input.0.inp | awk -F '{' '{print $2}' | awk -F '}' '{print $1}' >> inp0.out

# now in to python