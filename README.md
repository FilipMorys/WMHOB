# WMHOB
## Scripts to preprocess and analyse UKBB data for the WMHOB project
### 1. Analysis scripts
UKBB_WMHOB_stripped: whole brain analysis of cortical thickness, volume and subcortical volumes
UKBB_mediation_WMH_stripped: whole brain analysis of mediation BMI -> White matter hyperintensities -> CT/Volume + FA/MD
WMHOB_parallel_mediation_stripped: Analysis of mediation: BMI/WHR -> metabolic syndrome -> WMH
WMHOB_SEM_stripped: Script for the structural equation model in lavaan

### 2. Plotting scripts
All scripts use freesurfer_statsurf_display https://developmentalimagingmcri.github.io/freesurfer_statsurf_display/
New sciprts for subcortical plotting: MATLAB generates NIFTI files with t-values in significant subcortical structures, nilearn plots it on a brain image
