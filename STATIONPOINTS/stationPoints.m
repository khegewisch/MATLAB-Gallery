%NAME:stationPoints.m
%DESCRIPTION:
%INPUTS:stationPoints.mat
%USES: m_map.m, plot_points.m,freezecolors.m(http://www.mathworks.com/matlabcentral/fileexchange/7943-freezecolors---unfreezecolors)
%OUTPUTS:stationPoints.png

	addpath('/home/katherine/MATLAB/m_map'); %m_map.m
	addpath('/home/katherine/MATLAB'); %freezecolors.m

	%==================
	%  PARAMETERS
	%==================
	%marker sizes,font size/name on figure
	markerSize=6;
	fs=16; %fontsize
	ff='luxi sans'; %fontname
	%==================
	%  LOAD DATA 
	%==================
	%open file for loading
	matobj=matfile('stationPoints.mat');
	%load lat/lon
	lat = matobj.lat;
	lon=matobj.lon;

	%==================
	%   PLOT THE TOPOGRAPHY BACKGROUND
	%==================
	%load the topography lat/lon/elev data
	lat_el = matobj.yy;lat_el = lat_el(:,1);
	lon_el = matobj.xx;lon_el=lon_el(1,:)';
	elev=matobj.el;

	padding=0.0033;

	%find subset of the elevation data
	ind_lat = find(lat_el>=min(lat)-padding & lat_el<=max(lat)+padding);
	ind_lon = find(lon_el>=min(lon)-padding & lon_el<=max(lon)+padding);
	elev=elev(ind_lat,ind_lon);
	lat_el=lat_el(ind_lat);
	lon_el=lon_el(ind_lon);

	%plot the elevation background
	[x y]=meshgrid(lon_el,lat_el);
	makemap(x,y,elev,[min(elev) max(elev)]);

	%plot colorbar
	hc=colorbar;
	%set colormap
	colormap(gray);
	m_grid('fontsize',fs,'fontname',ff);
	set(gca,'fontsize',fs,'fontname',ff);

	%need to freeze the colors of this background plot to be able to plot on top of it
	freezeColors;
	hold on;

	%==================
	%   GET TAVG
	%==================
	%calculate avg stream temperature (over all days Jun 1 to Sept 30 and over all 10 years: 1999-2008)
	Tavg = squeeze(nanmean(nanmean(matobj.strm,1),2));

	%==================
	%   PLOT THE TAVG AT STATION POINTS OVER THE BACKGROUND
	%==================
	%set the colorbar labels
	colorbarTicks=[floor(min(Tavg)):1: ceil(max(Tavg))];
	numColors =length(colorbarTicks)-1;
	[h hc]=plot_points(lon,lat,Tavg,numColors,markerSize,min(colorbarTicks),max(colorbarTicks));

	%set range/label on colorbar
	caxis([min(colorbarTicks) max(colorbarTicks)]);
	set(hc,'YTick',colorbarTicks);
	set(gca,'fontsize',fs,'fontname',ff);
	set(get(hc,'ylabel'),'string','Temperature (deg C)','fontsize',fs,'fontname',ff);

	%set title
	title('Avg Summer Stream Temperatures (Kelly Creek,ID)','fontsize',fs,'fontname',ff);

	%==================
	%   SAVE FIGURE
	%==================
   	filename=['/home/katherine/stationPoints.png'];
        print('-dpng', filename);
