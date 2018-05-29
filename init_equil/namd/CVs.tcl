# Polar angles
# Theta
namespace eval polarTheta { } 
proc calc_polarTheta { args } {

    global polarTheta::x
    global polarTheta::y
    global polarTheta::z

    set x [ lindex [ lindex $args 0 ] 0 ]
    set y [ lindex [ lindex $args 0 ] 1 ]
    set z [ lindex [ lindex $args 0 ] 2 ]

    set f  [expr 180 / 3.1415926 * acos($z)]

    return $f
}


proc calc_polarTheta_gradient { args } {

    global polarTheta::x
    global polarTheta::y
    global polarTheta::z

    set gx 0
    set gy 0
    set gz [expr 180 / 3.1415926 * (-1.0) / sqrt(1.0 - $z * $z)]

    set g "{ $gx $gy $gz }"

    return $g
}

# Phi
namespace eval polarPhi { } 
proc calc_polarPhi { args } {

    global polarPhi::x
    global polarPhi::y
    global polarPhi::z

    set x [ lindex [ lindex $args 0 ] 0 ]
    set y [ lindex [ lindex $args 0 ] 1 ]
    set z [ lindex [ lindex $args 0 ] 2 ]

    set f  [expr 180 / 3.1415926 * atan2($y, $x)]

    return $f
}


proc calc_polarPhi_gradient { args } {

    global polarPhi::x
    global polarPhi::y
    global polarPhi::z

    set gx [expr 180 / 3.1415926 * (-$y) / ($x * $x + $y * $y)]
    set gy [expr 180 / 3.1415926 * $x / ($x * $x + $y * $y)]
    set gz 0

    set g "{ $gx $gy $gz }"

    return $g
}

# Euler angles
# Phi
namespace eval eulerPhi { } 
proc calc_eulerPhi { args } {

    global eulerPhi::q0
    global eulerPhi::q1
    global eulerPhi::q2
    global eulerPhi::q3

    set q0 [ lindex [ lindex $args 0 ] 0 ]
    set q1 [ lindex [ lindex $args 0 ] 1 ]
    set q2 [ lindex [ lindex $args 0 ] 2 ]
    set q3 [ lindex [ lindex $args 0 ] 3 ]

    set f  [ expr 180 / 3.1415926 * atan2(2 * ($q0 * $q1 + $q2 * $q3), 1 - 2 * ($q1 * $q1 + $q2 * $q2)) ]

    return $f
}


proc calc_eulerPhi_gradient { args } {

    global eulerPhi::q0
    global eulerPhi::q1
    global eulerPhi::q2
    global eulerPhi::q3

    set gq0 [expr 180 / 3.1415926 * 2 * $q1 * (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1) / ((2 * $q0 * $q1 + 2 * $q2 * $q3)**2 + (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1)**2)]
    set gq1 [expr 180 / 3.1415926 * (2 * $q0 * (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1) - 4 * $q1 * (-2 * $q0 * $q1 - 2 * $q2 * $q3)) / ((2 * $q0 * $q1 + 2 * $q2 * $q3)**2 + (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1)**2)]
    set gq2 [expr 180 / 3.1415926 * (-4 * $q2 * (-2 * $q0 * $q1 - 2 * $q2 * $q3) + 2 * $q3 * (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1)) / ((2 * $q0 * $q1 + 2 * $q2 * $q3)**2 + (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1)**2)]
    set gq3 [expr 180 / 3.1415926 * 2 * $q2 * (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1) / ((2 * $q0 * $q1 + 2 * $q2 * $q3)**2 + (-2 * $q1 * $q1 - 2 * $q2 * $q2 + 1)**2)]

    set g "{ $gq0 $gq1 $gq2 $gq3 }"

    return $g
}


# Psi
namespace eval eulerPsi { } 
proc calc_eulerPsi { args } {

    global eulerPsi::q0
    global eulerPsi::q1
    global eulerPsi::q2
    global eulerPsi::q3

    set q0 [ lindex [ lindex $args 0 ] 0 ]
    set q1 [ lindex [ lindex $args 0 ] 1 ]
    set q2 [ lindex [ lindex $args 0 ] 2 ]
    set q3 [ lindex [ lindex $args 0 ] 3 ]

    set f  [ expr 180 / 3.1415926 * atan2(2 * ($q0 * $q3 + $q1 * $q2), 1 - 2 * ($q2 * $q2 + $q3 * $q3)) ]

    return $f
}

proc calc_eulerPsi_gradient { args } {

    global eulerPsi::q0
    global eulerPsi::q1
    global eulerPsi::q2
    global eulerPsi::q3

    set gq0 [expr 180 / 3.1415926 * 2 * $q3 * (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1) / ((2 * $q0 * $q3 + 2 * $q1 * $q2)**2 + (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1)**2)]
    set gq1 [expr 180 / 3.1415926 * 2 * $q2 * (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1) / ((2 * $q0 * $q3 + 2 * $q1 * $q2)**2 + (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1)**2)]
    set gq2 [expr 180 / 3.1415926 * (2 * $q1 * (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1) - 4 * $q2 * (-2 * $q0 * $q3 - 2 * $q1 * $q2)) / ((2 * $q0 * $q3 + 2 * $q1 * $q2)**2 + (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1)**2)]
    set gq3 [expr 180 / 3.1415926 * (2 * $q0 * (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1) - 4 * $q3 * (-2 * $q0 * $q3 - 2 * $q1 * $q2)) / ((2 * $q0 * $q3 + 2 * $q1 * $q2)**2 + (-2 * $q2 * $q2 - 2 * $q3 * $q3 + 1)**2)]

    set g "{ $gq0 $gq1 $gq2 $gq3 }"

    return $g
}

# Theta
namespace eval eulerTheta { } 
proc calc_eulerTheta { args } {

    global eulerTheta::q0
    global eulerTheta::q1
    global eulerTheta::q2
    global eulerTheta::q3

    set q0 [ lindex [ lindex $args 0 ] 0 ]
    set q1 [ lindex [ lindex $args 0 ] 1 ]
    set q2 [ lindex [ lindex $args 0 ] 2 ]
    set q3 [ lindex [ lindex $args 0 ] 3 ]

    set f  [ expr 180 / 3.1415926 * asin(2 * ($q0 * $q2 - $q3 * $q1)) ]

    return $f
}

proc calc_eulerTheta_gradient { args } {

    global eulerTheta::q0
    global eulerTheta::q1
    global eulerTheta::q2
    global eulerTheta::q3

    set gq0 [expr 180 / 3.1415926 * 2 * $q2 / sqrt(-(2 * $q0 * $q2 - 2 * $q1 * $q3)**2 + 1)]
    set gq1 [expr 180 / 3.1415926 * -2 * $q3 / sqrt(-(2 * $q0 * $q2 - 2 * $q1 * $q3)**2 + 1)]
    set gq2 [expr 180 / 3.1415926 * 2 * $q0 / sqrt(-(2 * $q0 * $q2 - 2 * $q1 * $q3)**2 + 1)]
    set gq3 [expr 180 / 3.1415926 * -2 * $q1 / sqrt(-(2 * $q0 * $q2 - 2 * $q1 * $q3)**2 + 1)]

    set g "{ $gq0 $gq1 $gq2 $gq3 }"

    return $g
}
