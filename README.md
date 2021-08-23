# plot_timeseries_NS

This repositiory contain scripts for an auxiliary DMQC step for checking the quality of the salinity measurements delivered by Argo Floats operating in the Nordic Seas. This method is complementary to the OWC toolbox: https://github.com/ArgoDMQC/matlab_owc.

The scripts plot timeseries of interpolated salinity at given pressure level(s) from two sources: the ship-born CTD reference data base (CTD-RDB) and a given Argo float. The plots show the data separated in the four deep basins of the Nordic Seas (NS).  


## Observations

*Basins Definitions:*
The definition of the basins is highly dependent on the bathymetry. The repository includes definitions based on the etopo2 database but also scripts for define them based on user defined bathymetry.

*Modes and QF filtering:*
The user can define if the scripts plot the delayed mode or real time (includes automatically adjusted data) and the selected quality flags (applied only to salinity and pressure). The default selection is of data with flags 1 (good data), 2 (probably good data) and 3 (probably bad data).

## How to
Check the file: example_script.m 

For the preparation of interpolated reference database data for each basin the user can:
- use the function prep_interp_data, which arguments are the path for the reference database files (ctdrdb_path) and the  pressure levels for interpolation (ipres), as used in the OWC method and the ipres (the file generated are locally saved and can be reused later)
or
- use a the files interp_fh_NS.mat and interp_ctdrdb_NS.mat (included in the zip file interp_fh_ctdrdb_NS_20210903.zip), obtained using the function prep_interp_data using the latest ship-born CTD reference database (2021v01) and ipres between 800 and 2000 db with 10 db resolution.

The user wishes can also use another reference database (see function interp_basin_NS) or another bathymetry database (see function interp_fh_NS).

The netcdf file for the float(s) that are to be ploted should be locally saved and refered to using their WMO number (float) and their path (path_float). The data is read and then classify into the NS basins.

Finally the function plot_classfloatprof returns a figure showing the profile positions and their classification, and plot_eachbasinprof plots a timeseries (for each basin) of both the reference and argo data in the user defined pressure level. See the wikipage for examples.

## Requirements

- GSW toolbox's gsw_f function (calculates the Coriolis parameter)
- Ingrid Angel's utility functions
  https://github.com/imab4bsh/imab
- m_map with bathymetries
  https://www.eoas.ubc.ca/~rich/map.html

## Funding

This work is part of the project EA-RISE funded by the European Union’s Horizon 2020 research and innovation programme under grant agreement No. 824131

<img src="https://www.euro-argo.eu/var/storage/images/_aliases/fullsize/medias-ifremer/medias-euro_argo/logos/euro-argo-rise-logo/1688041-1-eng-GB/Euro-argo-RISE-logo.png" width="100" />

and is developed at the Federal Maritime and Hydrographic Agency (Bundesamt für Seeschifffahrt und Hydrographie, BSH) 

<img src="https://www.bsh.de/SiteGlobals/Frontend/Images/logo.png?__blob=normal&v=9" width="50" />

