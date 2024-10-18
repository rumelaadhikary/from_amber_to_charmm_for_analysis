Procedure to make charmm pdb-psf from amber files.

Step-1: Use parmed to create a psf and crd file from input prmtop and inpcrd file.
        [ The psf file obtained from this step is compatible with the dcd files obtained
        from OpenMM simulation using amber files. The only problem is that this pdb has 
	only one segment and the residues are in that format, which consider the molecule 
	as a long chain of peptide molecules. To use our existing analysis protocol of
	different molecule, we have to change this. ]

step-2: To make a pdb-psf set with each molecule having different identity, use the charmm psf and any dcd. Instead of using dcd 
	one can use any pdb which is compatible with the charmm psf. (Checking through VMD is
	recomended). For dcd take the last frame, and make pdb files using the tcl code. This 
	pdb's are in amber format. They have to change in charmm format.

step-3: After chaning from amber format to charmm format, use the code which takes pdb files
	as an input, give segment name and combine then. From there we will get a pdb-psf set 
	with each molecule with individual segment name. Use this psf and the dcd to the analysis 
	protocol already created.


Codes:

python3 amber_test_parmed.py [input inpcrd and prmtop file]
vmd -dispdev text -e make_pdb_files.tcl [input charmm psf and dcd file]
vmd -dispdev text -e psfgen-many-mol.tcl [input single molecule pdbs]
