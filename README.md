# plot_timeseries_NS

This repositiory contain scripts for an auxiliary DMQC step for checking the quality of the salinity measurements delivered by Argo Floats operating in the Nordic Seas. This method is complementary to the OWC toolbox: https://github.com/ArgoDMQC/matlab_owc.

The scripts plot timeseries of interpolated salinity at given pressure level(s) from two sources: the ship-born CTD reference data base (CTD-RDB) and a given Argo float. The plots show the data separated in the four deep basins of the Nordic Seas (NS).  


## Observations

*Basins Definitions:*
The definition of the basins is highly dependent on the bathymetry. The repository includes definitions based on the etopo2 database but also scripts for define them based on user defined bathymetry.

*Modes and QF filtering:*
The user can define if the scripts plot the delayed mode or real time (includes automatically adjusted data) and the selected quality flags (applied only to salinity and pressure). The default selection is of data with flags 1 (good data), 2 (probably good data) and 3 (probably bad data).

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

