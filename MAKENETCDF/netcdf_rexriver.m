region_string ='SPU';
inDir = ['/cyclone/CMIP5/DAILY/STATION_DATA/',region_string,'/SNOTEL/'];
outDir = ['/cyclone/CMIP5/DAILY/STATION_DATA/',region_string,'/SNOTEL/'];
 load([inDir,region_string,'_SnotelStationData.mat'],'tmax','tmin','ppt','lat','lon','ell','station_name','units','years','station_type');



s_index = find(strcmp(station_name,'REX RIVER'));


tmax = tmax(:,:,s_index);
tmin = tmin(:,:,s_index);
ppt = ppt(:,:,s_index);
lat=lat(s_index);
lon=lon(s_index);
ell=ell(s_index);

FULLFILENAME ='rex_river.nc'

days=1:365;	

save('make_netcdf.mat','-v7.3','ppt','tmax','tmin','lat','lon','ell','units');




nccreate(FULLFILENAME,'tmax','Dimensions',{'rows',length(days),'columns',length(years)});
ncwrite(FULLFILENAME,'tmax',tmax);
ncwriteatt(FULLFILENAME,'tmax','units','Kelvin');
ncwriteatt(FULLFILENAME,'tmax','description','Daily Max Temperature');
ncwriteatt(FULLFILENAME,'tmax','location','Rex River SNOTEL Station');

nccreate(FULLFILENAME,'tmin','Dimensions',{'rows',length(days),'columns',length(years)});
ncwrite(FULLFILENAME,'tmin',tmin);
ncwriteatt(FULLFILENAME,'tmin','units','Kelvin');
ncwriteatt(FULLFILENAME,'tmin','description','Daily Min Temperature');
ncwriteatt(FULLFILENAME,'tmin','location','Rex River SNOTEL Station');

nccreate(FULLFILENAME,'ppt','Dimensions',{'rows',length(days),'columns',length(years)});
ncwrite(FULLFILENAME,'ppt',ppt);
ncwriteatt(FULLFILENAME,'ppt','units','inches');
ncwriteatt(FULLFILENAME,'ppt','description','Daily Precipitation Amount');
ncwriteatt(FULLFILENAME,'ppt','location','Rex River SNOTEL Station');

nccreate(FULLFILENAME,'lat');
ncwrite(FULLFILENAME,'lat',lat);

nccreate(FULLFILENAME,'lon');
ncwrite(FULLFILENAME,'lon',lon);

nccreate(FULLFILENAME,'ell');
ncwrite(FULLFILENAME,'ell',ell);

nccreate(FULLFILENAME,'years','Dimensions',{'years',length(years)});
ncwrite(FULLFILENAME,'years',years');


nccreate(FULLFILENAME,'author','Dimensions',{'author',Inf},'Datatype','char');
ncwrite(FULLFILENAME,'author',char('K. Hegewisch(khegewisch@uidaho.edu), J.Abatzogou(jabatzoglou@uidaho.edu), University of Idaho'));

