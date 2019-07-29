#!/usr/bin/env python
"""
Generates resampling indices for all Cammoun et al., 2012, *J Neurosci Methods*
parcellation resolutions (68, 114, 219, 448, and 1000 nodes).

Uses spatially-autocorrelated null model based on rotations of spherical
projection of cortex as in Alexander-Bloch et al., 2018, *NeuroImage*

Saves resampling indices to `spinmat.mat` in `../data` directory
"""

import os

import numpy as np
from scipy import io as sio

from netneurotools import datasets, freesurfer, stats

projdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

if __name__ == '__main__':
    # this will fetch Freesurfer annotation files for the Cammoun parcellation
    # they will be saved to ~/nnt-data/atl-cammoun2012
    surf_files = datasets.fetch_cammoun2012('surface')

    spinmat = []
    for scale, (lh, rh) in surf_files.items():
        print('Running {}'.format(scale))

        # find spherical coordinates of the parcels + hemisphere assignments
        coords, hemi = freesurfer.find_fsaverage_centroids(lh, rh)

        # generate the rotations / resampling indices
        spins, cost = stats.gen_spinsamples(coords, hemi, exact=False,
                                            seed=1234, n_rotate=10000)
        spinmat.append(spins.astype('int16'))

    # convert list to an object array to ensure it will be loaded as a cell
    # array by Matlab
    mat = dict(spinmat=np.array(spinmat, dtype=object))
    fpath = os.path.join(projdir, 'data', 'spinmat.mat')
    sio.savemat(fpath, mat)
