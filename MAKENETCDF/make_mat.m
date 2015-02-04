region_string ='SPU';
inDir = ['/cyclone/CMIP5/DAILY/STATION_DATA/',region_string,'/SNOTEL/'];
outDir = ['/cyclone/CMIP5/DAILY/STATION_DATA/',region_string,'/SNOTEL/'];
 load([inDir,region_string,'_SnotelStationData.mat'],'tmax','tmin','ppt','lat','lon','ell','station_name','units','years','station_type');



s_index = find(strcmp(station_name,'REX RIVER'));


tmax = tmax(:,:,s_index);
lat=lat(s_index);
lon=lon(s_index);

FULLFILENAME ='rex_river.nc'

days=1:365;

save('make_netcdf.mat','-v7.3','tmax','lat','lon','units','days','years');
