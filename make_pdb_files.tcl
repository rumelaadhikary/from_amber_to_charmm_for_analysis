set psf_file charmm.psf
set dcd_file ../ff-800-mol-350A-box-amber-traj_1.dcd

mol load psf $psf_file dcd $dcd_file
set num_frame [molinfo top get numframes]
set i [expr $num_frame - 1]
#set sel [atomselect top "water and same residue as (within 2 of protein)"
#puts $i
set sel_protein [atomselect top "protein" frame $i]
set seglist_protein [$sel_protein get segid]
set seglist_protein [lsort -unique $seglist_protein]
set reslist_protein [$sel_protein get resid]
set reslist_protein [lsort -unique -integer $reslist_protein]
#set reslist_protein [lsort -integer $reslist_protein]
$sel_protein delete


#set reduced_reslist [expr [llength $reslist_protein] / 3]
set reduced_reslist [expr [llength $reslist_protein] / 2]
#set resid_list "1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3"
set resid_list "1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2"
set num_res 2
for {set k 0} {$k < $reduced_reslist} {incr k} {
	set k1 [expr $num_res*$k + 1]
	set k2 [expr $num_res*$k + 2]
	#set k3 [expr 3*$k + 3]
	#puts "$k1 $k2 $k3"
	#set sel [atomselect top "segname $seglist_protein and (resid $k1 or resid $k2 or resid $k3) " frame $i]
	set sel [atomselect top "segname $seglist_protein and (resid $k1 or resid $k2) " frame $i]
	#set resid [$sel get resid]
	#puts "$resid"
	$sel set resid $resid_list
	set j [expr $k + 1]
	$sel writepdb test/amber_test_$j.pdb
	$sel delete
}

exit
