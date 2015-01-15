%NAME: hardinessZones.m
%DESCRIPTION: This code make a map of the USDS hardiness zones using inputs for average annual minimum temperature at locations
%in Idaho.
%INPUTS: hardinessZones.mat
%USES:m_map, uashi
%OUTPUTS:hardinessZones.png

	addpath('/home/katherine/MATLAB/m_map:');%m_map

	%==============================
	% LOAD DATA
	%==============================
	myFile='hardinessZones.mat';
	load(myFile,'avgtasmin','lat','lon');

	
	[x y]=meshgrid(lon,lat);

	%==============================
	% CALCULATE HARDINESS ZONES
	%==============================
	%define zones
	tminZoneMins =[-30:5:20];
	tminZoneMaxs =[-25:5:25]
	zonenum = [4.5:.5:9];
	zonelabel={'4b';'5a';'5b';'6a';'6b';'7a';'7b';'8a';'8b';'9a';};

	%find zones
	for i = 1:length(lon);
		for j=1:length(lat);
			f=find(tminZoneMins<=avgtasmin(j,i) & tminZoneMaxs>=avgtasmin(j,i));
			if(~isempty(f));
				zones(j,i) = zonenum(f);
			else;
				zones(j,i) = NaN;
			end;
		end;
	end;

	%==============================
	% GET MASK FOR IDAHO
	%==============================
	%get a mask for just idaho
	S=load('usahi');
	statenames = S.statetext

	%find which number of structure for Idaho
	for i=1:51;
		if(strcmp(S.statetext(i).string,'Idaho'));
			ID_num=i;
		end;
	end;

	IDlat = S.stateline(ID_num).lat;
	IDlon = S.stateline(ID_num).long;

	%find the locations on our original map that are inside the ID stateline
	inID=inpolygon(x,y,IDlon,IDlat);
	zones(~inID)=NaN;


	%==============================
	% MAKE MAP
	%==============================
	%change colorbar to discrete colors
	cmin = min(zones(:));
	cmax = max(zones(:));
	numzones = length(cmin:.5:cmax);

	%make plot
	[x y]=meshgrid(lon,lat);
	makemap(x,y,zones,[min(zones(:)) max(zones(:))]);
	h = colorbar;
	colormap(jet(numzones));

	%label colorbar with the zonelabels
	caxis([cmin cmax+.5]);
	set(h,'YTickLabel',zonelabel(([cmin:.5:cmax]-cmin)./.5+1),'YTick',[cmin:.5:cmax]+.25);

	%set fonts used in figure
	fs=18;
	ff='luxi sans';
	set(h,'fontsize',fs,'fontname',ff);
	set(get(h,'xlabel'),'string','zone','fontsize',fs,'fontname',ff);
	title('USDA Hardiness Zones for Idaho','fontsize',fs,'fontname',ff);

	%==============================
	% SAVE FIGURE
	%==============================
   	filename='hardinessZones.png';
        print('-dpng', filename);



