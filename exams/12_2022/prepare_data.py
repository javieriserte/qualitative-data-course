from os.path import join
from Bio.PDB.PDBParser import PDBParser
from Bio.PDB.Model import Model
from itertools import combinations
import rmsd

from Bio import AlignIO
from xi_covutils.msa import gapstrip, pop_reference, write_msa, read_msa

def get_coor_from_model(model: Model):
    return [
        atom.get_coord()
        for atom in model.get_atoms()
    ]

def prepare_nmr_conformers(): 
    pdb_file = join(
        "data", "5yq3.pdb"
    )
    parser = PDBParser()
    struct = parser.get_structure("XXXX", pdb_file)
    models = list(struct.get_models())
    rmsd_data = {}
    for a, b in combinations(list(range(20)), 2):
        my_rmsd = rmsd.rmsd(
            get_coor_from_model(models[a]),
            get_coor_from_model(models[b])
        )
        rmsd_data[(a, b)] = my_rmsd
        rmsd_data[(b, a)] = my_rmsd
    for a in range(20):
        rmsd_data[(a, a)] = 0

    with open(join("data", "dist_mat.txt"), 'w') as fh:
        for a in range(20):
            values = " ".join([str(rmsd_data[(a,b)]) for b in range(20)])
            fh.write(f"{values}\n")

if __name__ == "__main__":
    prepare_nmr_conformers()
