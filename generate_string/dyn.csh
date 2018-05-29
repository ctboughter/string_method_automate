#!/bin/sh
#SBATCH --job-name=imp0rove
#SBATCH --output=pagdim.out
#SBATCH --partition=broadwl
#SBATCH --account=legacy
#SBATCH --qos=normal
#SBATCH --exclusive
#SBATCH --nodes=4
#SBATCH --time=24:00:00

source /etc/profile

module load namd
module load python

# So here we should be looping through,
# iteratively running the simulation and then
# calculating the new centers...
for i in {3..50}
do
    x=$(($i-1))    
    mpirun namd2 input.$x.inp >& input.$x.out
    ./newcenters_average.sh $x $i
done


