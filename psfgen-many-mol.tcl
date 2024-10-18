#vmd-tcl script for giving a merged pdb-psf set for molecules with multiple pdbs'

package require psfgen

#set charmm36_topology_path /home/rumela/My-install/NAMD/Force-field/CHARMM-36-jul18/toppar

set amber_topology_path /home/argha/my_install/NAMD/Force-field/CHARMM-36-jul18/toppar/non_charmm
topology $amber_topology_path/parm14sb_all.rtf
#topology $charmm36_topology_path/top_all36_prot.rtf
#topology $charmm36_topology_path/stream/prot/toppar_all36_prot_c36_d_aminoacids.str

set list_of_charecters {"A" "B" "C" "D" "E" "F" "G"
                        "H" "I" "J" "K" "L" "M" "N"
                        "O" "P" "Q" "R" "S" "T" "U"
                        "V" "W" "X" "Y" "Z"}

# generate random integer number in the range [min,max]
proc RandomInteger4 {min max} {
    return [expr {int(rand()*($max-$min+1)+$min)}]
}

# Generate a random string by picking charectors from a list
proc generate_one_string { list_of_charecters width } {
    set length_of_list [llength $list_of_charecters]
    set min 0
    set max [expr $length_of_list - 1]
    set output ""
    for {set i 0} {$i < $width} {incr i} {
        set index [RandomInteger4 $min $max]
        set output $output[lindex $list_of_charecters $index]
    }
    return $output
}

# Generate a list of random strings with unique entires. Each string
# has a specified width and the list consists of unique entries
proc generate_unique_list_of_strings { list_of_charecters width num_strings } {
    set list_of_strings ""
    while { [llength $list_of_strings] < $num_strings } {
        set one_string [generate_one_string $list_of_charecters $width]
        lappend list_of_strings $one_string
        set list_of_strings [lsort -unique $list_of_strings]
    }
    return $list_of_strings
}

set num_pdb 800

set list_of_residue [generate_unique_list_of_strings $list_of_charecters 4 $num_pdb ]

for {set j 0 } { $j < $num_pdb } {incr j } {
        set segment [lindex $list_of_residue $j]
	segment $segment {pdb test/amber_test_[expr $j+1].pdb
        }

    pdbalias atom PHE H1 HT1
    pdbalias atom PHE H2 HT2
    pdbalias atom PHE H3 HT3
    pdbalias atom PHE HB2 HB1
    pdbalias atom PHE HB3 HB2
    pdbalias atom PHE H HN
    pdbalias atom PHE O OT1
    pdbalias atom PHE OXT OT2
	coordpdb test/amber_test_[expr $j+1].pdb $segment
    guesscoord
    regenerate angles dihedrals

}

writepdb ff_final_mol_$num_pdb-mol_amber.pdb
writepsf ff_final_mol_$num_pdb-mol_amber.psf
	
exit
