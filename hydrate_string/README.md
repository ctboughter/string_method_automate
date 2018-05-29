So here we have my final baby. I've officially figured out
how to automatically hydrate all of my systems and give
them the exact same number of atoms to make the replica
exchange simulations work out in a minimal waterbox
(Should probably work on a way to guess what the minimal
waterbox should be... that could probably be quite easy).

It turns out that the CHARMM steps are not really deterministic.
You can get different results each time you run, so you need ways
to ADD back waters to the simulation box...

Anyway, here are the general steps once an initial system
has been used and you have already generated the initial string
in vacuum.

1. Use hydrate_systems.sh to copy over those dcd files, all of
the input files you could ever need, and the pdb/psf you used
to generate the string

2. use dcd_to_pdb.tcl (in vmd) to convert your ending trajectory
to a nice little pdb snapshot

3. use pdb_to_crd.sh to make those nice little pdbs charmm-readable

4. Use edit_charmm.sh to change all of the (hopefully identical)
CHARMM input scripts for each individual coor# (poorly worded, but run the damn script)

4. use run_charmm.sh to get your new, fully hydrated systems (note,
this might take a hot minute. Be sure to submit as a job)

5. Have fun with it! (jk there'll probably be more instructions here soon)

XOXO
- Christopher T Boughter 1/18/18