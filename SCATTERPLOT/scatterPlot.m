%NAME: scatterPlot.m
%DESCRIPTION: This code load in 
%
	addpath('/storage/CODE/MATLAB/:'); %path to rgb.m (http://www.mathworks.com/matlabcentral/fileexchange/24497-rgb-triple-of-color-name--version-2)
	%==========================
	%   LOAD DATA
	%==========================
	myFile='scatterPlot.mat';
	load(myFile,'prec','temp','lat','lon','MODELS','years','units');
	%Note: MODELS was created as a string array like this:
	%MODELS={'bcc-csm1-1';'bcc-csm1-1-m';'BNU-ESM'};

	%==========================
	%   FIND INDICES CORRESPONDING TO SPECIFIED YEARS
	%==========================
	HIST_IND = [1950:2005]-1950+1;
	FUT_IND = [2041:2070]-1950+1;

	%==========================
	%   GET AVG TEMPERATURE AND AVG PRECIPITATION
	%==========================
	seasonT=[1:12]; %annual (all months)
	seasonP=[6:8]; %summer (June, July, August 6,7,8)
	%difference change for temperature, ratio of change for precipitation (here averages are being done over the months(3), then the years(4)
	annualT = nanmean(nanmean(temp(:,:,:,FUT_IND,:),3),4)- nanmean(nanmean(temp(:,:,:,HIST_IND,:),3),4);
	summerP= (nanmean(nansum(prec(:,:,seasonP,FUT_IND,:),3),4) - nanmean(nansum(prec(:,:,seasonP,HIST_IND,:),3),4))./nanmean(nansum(prec(:,:,seasonP,HIST_IND,:),3),4)*100.;

	%==========================
	%   GET SPATIAL AVG OVER SPATIAL GRID
	%==========================
	%get spatial avg of all the changes (here averages are being done over the longitudes(2), then the latitudes(1)
	avgannualT = squeeze(nanmean(nanmean(annualT,2),1));
	avgsummerP = squeeze(nanmean(nanmean(summerP,2),1));

	%==========================
	%   PLOT A SCATTER OF THE AVG PREC, AVG TEMP FOR EACH MODEL
	%==========================
	%plot the markers
	C={rgb('Green');rgb('Black');rgb('Red');rgb('Blue');};
	M ={'d';'o';'v';'s';'>';'<';'p';'h';'x';'+';'*'};
	NUM_COLORS = length(C);
	NUM_MARKERS = length(M) ;

	x=avgannualT;
	y=avgsummerP;
	for m=1:length(MODELS);
		a = plot(x(m),y(m),'*');  %plots a '*' at each point (x(m),y(m))
		hold on;		  %hold plot for more plotting
		%set the marker/color/etc for the point plotted
		set(a,'marker',M{floor((m-1)/NUM_COLORS)+1} ,...  
			'MarkerEdgeColor',C{mod(m-1,NUM_COLORS)+1},...
			'MarkerFaceColor',C{mod(m-1,NUM_COLORS)+1},...
			'markersize',14);
	end;

	%font size/name
	fs=18;
	fn='luxi sans';

	%set x/y labels and title
	xlabel('Change in Annual Temperature (deg C)','fontsize',fs,'fontname',fn);
	ylabel('Precent change in Summer Precipitation(%)','fontsize',fs,'fontname',fn);
	title('Projected Idaho Changes from RCP4.5','fontsize',18);

	%set text properties of axes	
	set(gca,'fontsize',fs,'fontname',fn); 

	%set legend with all the model names
	legend(MODELS,'Location','BestOutside','fontsize',10,'fontname',fn); 

	%==========================
	%   SAVE PLOT
	%==========================
   	filename=['scatterPlot.png'];
        print('-dpng', filename);

