%make_netcdf.m
%DESCRIPTION: 	This code plot a climograph (a bar chart for avg precipitation and a line plot overlay for avg temperature)
%INPUTS: 	make_netcdf.mat
%USES:		make_netcdf.m
%OUTPUTS:	make_netcdf.nc	

	%================================
	%LOAD DATA
	%================================
	myFile='make_netcdf.mat';
	load(myFile,'tmax','lat','lon','units','years','days');

	%================================
	%WRITE NETCDF
	%================================
	FULLFILENAME = 'make_netcdf.nc'

	%write 2-dim array to file: 
	nccreate(FULLFILENAME,'tmax','Dimensions',{'rows',length(days),'columns',length(years)});
	ncwrite(FULLFILENAME,'tmax',tmax);
	%write some metadata attributes
	ncwriteatt(FULLFILENAME,'tmax','units','Kelvin');
	ncwriteatt(FULLFILENAME,'tmax','description','Daily Max Temperature');
	ncwriteatt(FULLFILENAME,'tmax','location','Rex River SNOTEL Station');

	%write scalar to file
	nccreate(FULLFILENAME,'lat');
	ncwrite(FULLFILENAME,'lat',lat);

	nccreate(FULLFILENAME,'lon');
	ncwrite(FULLFILENAME,'lon',lon);

	%write 1-D vector to file
	nccreate(FULLFILENAME,'years','Dimensions',{'years',length(years)});
	ncwrite(FULLFILENAME,'years',years');

	%write string to file
	nccreate(FULLFILENAME,'author','Dimensions',{'author',Inf},'Datatype','char');
	ncwrite(FULLFILENAME,'author',char('K. Hegewisch(khegewisch@uidaho.edu), University of Idaho'));


	%================================
	%VIEW NETCDF INFO
	%================================
	ncdisp(FULLFILENAME);

