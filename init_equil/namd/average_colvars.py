
# coding: utf-8

# # Making a Script to Average the Colvars
#     Want to replace the DHAM algorithm for generating the initial path of a string.
#     Need to be relatively efficient, fast, and easy to run on Midway
#     
# ### Assume that every file we need is in the current directory... And we're off

# In[1]:

## import all of our fun stuff

import pandas
import numpy as np
import matplotlib.pyplot as mp
import sys
import mdtraj as md
import itertools

inp=sys.argv[1]
# In[16]:

# The bash commands above this called python script convert the *colvars.traj file to a *out file
x=pandas.read_csv('data.'+inp+'.out',header=None)
colvar=x.as_matrix(columns=None)

# Import the input colvars that are used as reference
y=pandas.read_csv('inp.'+inp+'.out',header=None)
input=y.as_matrix(columns=None)
# this current method removes the first line of colvar (which isn't great)


# In[17]:

#Need to do that weird little thing where I make the [-180,180] range to [0,360]
for i in range(0,len(colvar[:,2])):
        if colvar[i,1] < 0:
            colvar[i,1]=colvar[i,1]+360
        if colvar[i,2] < 0:
            colvar[i,2]=colvar[i,2]+360
        if colvar[i,3] < 0:
            colvar[i,3]=colvar[i,3]+360
        if colvar[i,4] < 0:
            colvar[i,4]=colvar[i,4]+360
        if colvar[i,5] < 0:
            colvar[i,5]=colvar[i,5]+360
# Remember that these are scalars, so we don't need to iterate through
if input[1] < 0:
    input[1]=input[1]+360
if input[2] < 0:
    input[2]=input[2]+360
if input[3] < 0:
    input[3]=input[3]+360
if input[4] < 0:
    input[4]=input[4]+360
if input[5] < 0:
    input[5]=input[5]+360

# In[18]:

# so we have, in order: Pin, Theta, Phi, Psi, theta_low, phi_low, R
# This can change from colvars to colvars though, so make sure you check...
end=len(colvar)
# Take all the averages, but throw out the first 500 data points so it's equilibrated
Pinavg=np.average(colvar[500:end,0])
Theta_avg=np.average(colvar[500:end,1])
Phi_avg=np.average(colvar[500:end,2])
Psi_avg=np.average(colvar[500:end,3])
theta_l_avg=np.average(colvar[500:end,4])
phi_l_avg=np.average(colvar[500:end,5])
RAVG=np.average(colvar[500:end,6])

# In[19]:

# Take all the stdevs
Pinstd=np.std(colvar[500:end,0])
Theta_std=np.std(colvar[500:end,1])
Phi_std=np.std(colvar[500:end,2])
Psi_std=np.std(colvar[500:end,3])
theta_l_std=np.std(colvar[500:end,4])
phi_l_std=np.std(colvar[500:end,5])
Rstd=np.std(colvar[500:end,6])

# In[20]:

# Get our colvar inputs (order Theta, Phi, Psi, theta_low, phi_low, R)
theta=input[0]
phi=input[1]
psi=input[2]
theta_low=input[3]
phi_low=input[4]
R=input[5]
pin=input[6]
###### NEW ADDITION: CALCULATE MINDIST
# A little slow, could be better... but good enough:

# md.load_frame very nicely only loads in one frame, which be a bit better
# So note that even though VMD says we have 200 frames per trajectory
# I think MDTraj shitcans this initial pdb frame, thus the 199 here
trj=md.load_frame('hydrate.'+inp+'.dcd',2,top='../step3_pbcsetup.pdb')
top=trj.topology

# Try doing it Atom by Atom:
A=top.select("segname PROA")
B=top.select("segname PROB")
pairs=list(itertools.product(A,B))
# This periodic=False was KEY for vacuum sim... double check for hydrate
y=md.compute_distances(trj,pairs,periodic=False)

# I think compute_distances assumes you will always have multiple frames
# Even though we only have one frame, we still have to specify we
# Want a min from frame 0.
#MDtraj does stuff in nm, want in angstrom
MinDist=min(y[0])*10.0

# In[23]:

# Great now let's calculate our new values
# Want to weight the new angles based on the initial colvar

# Let's make an equation based on mindist!
s=1.0-1.0/144*(MinDist-12)**2 # w is between 0 and 1 always
# Little failsafe here so we stop updating.
if MinDist > 12:
    s=1
    print ('hello')

theta_new=(1-s)*Theta_avg+s*theta
phi_new=(1-s)*Phi_avg+s*phi
psi_new=(1-s)*Psi_avg+s*psi
theta_l_new=(1-s)*theta_l_avg+s*theta_low
phi_l_new=(1-s)*phi_l_avg+s*phi_low
print('new_colvar','input_colvar','average_colvar')
print(theta_new,theta,Theta_avg)
print(phi_new,phi,Phi_avg)
print(psi_new,psi,Psi_avg)
print(theta_l_new,theta_low,theta_l_avg)
print(phi_l_new,phi_low,phi_l_avg)


# In[24]:

# R new is going to be created also in a creative way hopefully, but for now let's
# just do a simple ∆R and let it be.


dR=0.5
# Once we get past the cutoff, can really get protein TF outta here
if MinDist > 12:
    dR=1
R_new=R+dR
Pin_new=pin+dR

# In[28]:

# Save these new beautiful variables
## HERE WE REMOVE PIN and R updates because we are REFINING the string
final=[theta_new,phi_new,psi_new,theta_l_new,phi_l_new]
distt=[MinDist]
# print 5 digits after the decimal place
np.savetxt('inp_new.'+inp+'.out',final,fmt='%.5e')
np.savetxt('MinDist.'+inp+'.out',distt,fmt='%.4e')

standard=[Theta_std,Phi_std,Psi_std,theta_l_std,phi_l_std,Rstd,Pinstd]
np.savetxt('std.'+inp+'.out',standard,fmt='%.5e')

average=[Theta_avg,Phi_avg,Psi_avg,theta_l_avg,phi_l_avg,RAVG,Pinavg]
np.savetxt('avg.'+inp+'.out',average,fmt='%.5e')
