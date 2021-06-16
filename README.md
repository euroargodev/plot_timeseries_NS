# plot_timeseries_NS

This repository contatins scripts to plot timeseries of interpolated salinity (given pressure levels) from the CTD-RDB in the four deep basins in the Nordic Seas to compare them with the timeseries from an Argo float.
This is an auxiliary DMQC procedure.

## Observations

*Basins Definitions: *
The definition of the basins is highly dependent on the bathymetry. They should be improved (See Greenland Sea, which still has a part from a neighbor basin).

*QF filtering: *
By default the script read_argo assigns a NaN value to all measured variables of a sample (P,T,S) if on of them has a QF>1.

## Requirements

- Ingrid Angel's utility functions
  https://github.com/imab4bsh/imab
- m_map with bathymetries
	https://www.eoas.ubc.ca/~rich/map.html
- GSW toolbox's gsw_f function (calculates the Coriolis parameter)
- export_fig to save figures (optional)
	https://github.com/altmany/export_fig
	https://www.mathworks.com/matlabcentral/fileexchange/23629-export_fig

## Funding

This work is part of the project EA-RISE funded by the European Union’s Horizon 2020 research and innovation programme under grant agreement No. 824131

<img src="https://www.euro-argo.eu/var/storage/images/_aliases/fullsize/medias-ifremer/medias-euro_argo/logos/euro-argo-rise-logo/1688041-1-eng-GB/Euro-argo-RISE-logo.png" width="100" />

and is developed at the Federal Maritime and Hydrographic Agency (Bundesamt für Seeschifffahrt und Hydrographie, BSH) 

<img src="https://www.bsh.de/SiteGlobals/Frontend/Images/logo.png?__blob=normal&v=9" width="50" />

