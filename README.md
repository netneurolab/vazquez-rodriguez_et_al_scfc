# Gradients of structure-function tethering across neocortex

[![DOI](https://zenodo.org/badge/173153146.svg)](https://zenodo.org/badge/latestdoi/173153146)

This repository contains processing scripts in support of the preprint:

Vázquez-Rodríguez, B., Suárez, L. E., Shafiei, G., Markello, R. D., Paquola, C., Hagmann, P., van den Heuvel, M. P., Bernhardt, B. C., Spreng, R. N., Mišić, B. (2019). Gradients of structure-function tethering across neocortex. *bioRxiv*, 561985. [https://doi.org/10.1101/561985](https://doi.org/10.1101/561985).

## Environment

All analyses were run with Matlab Version: 9.0.0.341360 (R2016a).
The [Brain Connectivity Toolbox](https://sites.google.com/site/bctnet/) and [Matlab Toolbox for Dimensionality Reduction](http://lvdmaaten.github.io/drtoolbox/) are assumed to be present in your Matlab path.

## Data

Functional and structural connectivity data were generously provided by collaborators and are not yet publicly available.
A *version* of the structural connectivity data used in this study is available on request at [Zenodo](https://sandbox.zenodo.org/record/252146#.W_O80xBRdqu).

## Code

### Scripts

* [`scpt_get_rsq.m`](scpt_get_rsq.m):
  Primary analysis script for calculating nodal R² values from multiple regression structure-function models. Uses adjusted R² as defined by Matlab's [`fitlm`](https://www.mathworks.com/help/stats/fitlm.html) routine.

* [`scpt_partitions.m`](scpt_partitions.m):
  Script to examine how nodal R² values (generated with `scpt_get_rsq.m`) are anatomically distributed, using partition assignments from (1) Yeo et al., 2011, *J Neurophysiol* and (2) von Economo & Kosinkas, 1925 (as provided by Scholtens et al., 2018, *NeuroImage*). Uses permutation-based null models to assess significance of anatomical distributions.

* [`scpt_gradient.m`](scpt_gradient.m):
  Script to generate diffusion map embedding of functional connectivity matrix. Compares resulting "functional gradient" with nodal R² values (generated with `scpt_get_rsq.m`).

### Functions

* [`fcn_communicability.m`](fcn_communicability.m):
  Function for calculating the "communicability" of binary (e.g., structural connectivity) networks. See docstring or refer to Estrada & Hatano, 2008, *Physical Review E* for more information.
