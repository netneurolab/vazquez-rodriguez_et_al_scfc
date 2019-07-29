# Gradients of structure-function tethering across neocortex

[![DOI](https://zenodo.org/badge/173153146.svg)](https://zenodo.org/badge/latestdoi/173153146)

This repository contains processing scripts in support of the preprint:

Vázquez-Rodríguez, B., Suárez, L. E., Shafiei, G., Markello, R. D., Paquola, C., Hagmann, P., van den Heuvel, M. P., Bernhardt, B. C., Spreng, R. N., Mišić, B. (2019). Gradients of structure-function tethering across neocortex. *bioRxiv*, 561985. [https://doi.org/10.1101/561985](https://doi.org/10.1101/561985).

## Environment

All analyses were run with Matlab Version: 9.0.0.341360 (R2016a).
The [Brain Connectivity Toolbox](https://sites.google.com/site/bctnet/) and [Matlab Toolbox for Dimensionality Reduction](http://lvdmaaten.github.io/drtoolbox/) are assumed to be present in your Matlab path.

## Data

* [`rsn_mapping.mat`](data/rsn_mapping.mat):
  Mapping of Cammoun et al., 2012, *J Neurosci Methods* cortical parcellations to partitions defined by Yeo et al., 2011, *J Neurophysiol*.
  Used in [`scpt_partitions.m`](code/scpt_partitions.m).
* [`ve_mapping.mat`](data/ve_mapping.mat):
  Mapping of Cammoun et al., 2012, *J Neurosci Methods* cortical parcellations to partitions defined by von Economo & Kosinkas, 1925 (as provided by Scholtens et al., 2018, *NeuroImage*).
  Used in [`scpt_partitions.m`](code/scpt_partitions.m).
* [`hcp_subjids.csv`](data/hcp_subjids.csv):
  List of IDs for HCP subjects used in reported validation analyses (see Vázquez-Rodríguez et al., 2019, *Methods: Data Acquisition - HCP*).

Group-consensus connectivity matrices were derived from functional and structural matrices provided by Griffa et al. on [Zenodo](https://doi.org/10.5281/zenodo.2872624).
Conensus matrices should be saved to a mat file (`data/consensus_connm.mat`) after generation for scripts to run correctly.

## Code

### Analysis scripts

These scripts were used in the results-generating analyses reported in the main text of Vázquez-Rodríguez et al., 2019.
Note that `scpt_get_rsq.m` must be run first as it generates results files used in the other scripts.

1. [`scpt_get_rsq.m`](code/scpt_get_rsq.m):
  Primary analysis script for calculating nodal R² values from multiple regression structure-function models.
  Uses [adjusted R²](https://www.mathworks.com/help/stats/linearmodel.html#bsz4dm2-1_sep_shared-Rsquared) as defined by Matlab's [`fitlm`](https://www.mathworks.com/help/stats/fitlm.html) routine.

2. [`scpt_partitions.m`](code/scpt_partitions.m):
  Script to examine how nodal R² values are anatomically distributed, using partition assignments from (1) Yeo et al., 2011, *J Neurophysiol* and (2) von Economo & Kosinkas, 1925 (as provided by Scholtens et al., 2018, *NeuroImage*).
  Uses spatially-autocorrelated null models to assess significance of anatomical distributions (i.e., Alexander-Bloch et al., 2018, *NeuroImage*).

3. [`scpt_gradient.m`](code/scpt_gradient.m):
  Script to generate diffusion map embedding of functional connectivity matrix.
  Compares resulting "functional gradients" with nodal R² values.

### Auxiliary scripts

These scripts were used to generate intermediate files supporting the analysis scripts described above.

* [`scpt_get_spinmat.py`](code/scpt_get_spinmat.py):
  Python script to generate the resampling indices used in spatially-autocorrelated null models used in [`scpt_partitions.m`](code/scpt_partitions.m).
  The following software versions were used to generate the resampling indices:

  * Python: v3.6.8
  * [`numpy`](https://docs.scipy.org/doc/numpy/reference/): v1.16.3,
  * [`scipy`](https://docs.scipy.org/doc/scipy/reference/) v1.2.1, and
  * [`netneurotools`](https://github.com/netneurolab/netneurotools/tree/284fbee96e0d060c27cdd8ef32f8f9278a860548) v0.1+g32.g284fbee.dirty.
  
  CSV versions of the resampling indices for all parcellation resolutions can be found on [OSF](https://osf.io/62rbd/).

### Functions

* [`fcn_communicability.m`](code/fcn_communicability.m):
  Function for calculating the "communicability" of binary (e.g., structural connectivity) networks.
  See docstring of function or refer to Estrada & Hatano, 2008, *Physical Review E* for more information.
