import parmed as pmd

prmtop='../FF_800mol_350A_box_amber20.prmtop'
inpcrd='../FF_800mol_350A_box_amber20.inpcrd'
amber = pmd.load_file(prmtop, inpcrd)

# Save a CHARMM PSF and crd file
amber.save('charmm.psf')
amber.save('charmm.crd')
