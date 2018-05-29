#!/usr/bin/tclsh

# Honestly, this should be pretty self explanatory.
# There may be a better way to do this,
# but I hate TCL scripting.

for { set x 0} { $x <=75 } { incr x 1} {

    mol delete top
    mol load pdb coor$x/vac_protein.pdb
    mol addfile coor$x/vac_protein2.psf
    # Obviously here the frames can be flexible,
    # but be careful automating this script.
    # VMD IS WICKED FICKLE
    mol addfile coor$x/input.$x.dcd first 199 last 200

    set a [atomselect top "all"]
    $a writepdb coor$x/coor$x.pdb
}
