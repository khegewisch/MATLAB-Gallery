%NAME:pastaPlot.m
%DESCRIPTION:
%INPUTS:pastaPlot.mat
%USES:plot_patch.m,smooth.m
%OUTPUTS:pastaPlot.png


	addpath('/home/katherine/MATLAB/');
	%================================
	%  LOAD DATA
	%================================
	myFile='pastaPlot.mat';
	load(myFile,'rcp45','rcp85','HIST_YEARS','FUT_YEARS','MODELS');

	%================================
	%  SMOOTH DATA
	%================================
        HIST_YEAR_IND = HIST_YEARS - min(HIST_YEARS)+1;
        FUT_YEAR_IND = FUT_YEARS - min(HIST_YEARS)+1;

	%================================
	%  PLOT LINES OF DATA
	%================================
	plot([1950:2100],rcp45)
	set(gca,'fontsize',14,'fontname','Luxi Sans');
	title('Annual Temperature Projections from models under RCP4.5','fontsize',14);
	xlabel('Year','fontsize',14);
	ylabel('Avg Annual Temperature Anomaly (deg C)','fontsize',14);

	%================================
	%  GET 5%, 95% of DATA (for extremes of shading),smooth them and plot shading
	%================================
        LOW_P=5; %Lower percentile of distribution to take for patch
        HIGH_P=95; %Upper percentile of distribution to take for dpatch
        rcp45_low=prctile(rcp45,LOW_P,2);
        rcp85_low=prctile(rcp85,LOW_P,2);
        rcp45_high=prctile(rcp45,HIGH_P,2);
        rcp85_high=prctile(rcp85,HIGH_P,2);

	%smoothe the upper 95% and lower 5% of data over all models
        SMOOTHING_YRS = 11; %number of years to taking in moving smoothing window
        rcp45_low=smooth(rcp45_low,SMOOTHING_YRS,'moving');
        rcp85_low=smooth(rcp85_low,SMOOTHING_YRS,'moving');
        rcp45_high=smooth(rcp45_high,SMOOTHING_YRS,'moving');
        rcp85_high=smooth(rcp85_high,SMOOTHING_YRS,'moving');

        hist_low = rcp45_low(HIST_YEAR_IND);
        hist_high = rcp45_high(HIST_YEAR_IND);

	%================================
	%  PLOT SHADING
	%================================
	%plot shading
        FUT85_COLOR = rgb('Lime');
        FUT45_COLOR = rgb('Aqua');
        HIST_COLOR = rgb('Gray');
	MODEL_COLOR = 'k';
	TARG_MODELS = [5];
        FUT_TRANS = 0.5;
        HIST_TRANS = 0.5;
	lw = 2;
        h=figure;
    	set(gca,'Box','on')
        plot_patch(FUT_YEARS,rcp45_low(FUT_YEAR_IND)',rcp45_high(FUT_YEAR_IND)',...
		FUT45_COLOR,h,FUT_TRANS);
        plot_patch(FUT_YEARS,rcp85_low(FUT_YEAR_IND)',rcp85_high(FUT_YEAR_IND)',...
		FUT85_COLOR,h,FUT_TRANS);
        plot_patch(HIST_YEARS,hist_low',hist_high',HIST_COLOR,h,HIST_TRANS);


	%================================
	%  PLOT PASTA OF LINES
	%================================
	hold on;
	TARG_MODELS = [5];
	for m=1:10;
		a=plot([HIST_YEARS FUT_YEARS]',rcp85(:,m));set(a,'color',rgb('LightGray'));
		set(a,'LineWidth',1);hold on;
	end;

	%================================
        %  PLOT EXAMPLE LINE
        %================================
        hold on;
        TARG_MODELS = [5];
        for m=TARG_MODELS;
                a=plot([HIST_YEARS FUT_YEARS]',rcp85(:,m));set(a,'color',MODEL_COLOR);
                set(a,'LineWidth',lw);hold on;
        end;


	%================================
	% ADD TEXT TO FIGURE
	%================================
        firstline='Anomalies in Avg Annual Temperatures';
        secondline ='38-41\circN, 114-116\circW';
        title({firstline;secondline},'fontsize',20,'fontname','Luxi Sans');
        xlabel('Years', 'fontsize',20,'fontname','Luxi Sans');
        ylabel('Departure From Normal (\circC)','fontsize',20,'fontname','Luxi Sans');
	set(gca,'fontsize',20,'fontname','Luxi Sans');

	%================================
	% ADD CUSTOM LEGEND 
	%================================
	ms=10;
	fs=16;
	X=[1960 1965];
	Y=[9:-2:3];
	YSPACE = 0.1;
	XSPACE = 2;
	i=1;
	plot(X(1),Y(i),'s','MarkerSize',ms,'MarkerFaceColor',FUT45_COLOR,...
		'MarkerEdgeColor',FUT45_COLOR);
	text(X(2),Y(i)-YSPACE,'RCP4.5','fontsize',fs);
	i=2;
	plot(X(1),Y(i),'s','MarkerSize',ms,'MarkerFaceColor',FUT85_COLOR,...
		'MarkerEdgeColor',FUT85_COLOR);
	text(X(2),Y(i)-YSPACE,'RCP8.5','fontsize',fs);
	i=3;
	plot(X(1),Y(i),'s','MarkerSize',ms,'MarkerFaceColor',HIST_COLOR,...
		'MarkerEdgeColor',HIST_COLOR);
	text(X(2),Y(i)-YSPACE,'HISTORICAL','fontsize',fs);
	i=4;
	plot([X(1)-XSPACE X(1)+XSPACE],[Y(i) Y(i)],MODEL_COLOR,'LineWidth',lw);
	text(X(2),Y(i)-YSPACE,'MIROC5 RCP8.5','fontsize',fs);

	%================================
	% ADD ZERO LINE
	%================================
        plot([min(HIST_YEARS) max(FUT_YEARS)],[0 0],'k');
	set(gca, 'LineWidth', 1.5)

	%================================
	% SAVE FIGURE
	%================================
        set(gca,'Box','on')
        filename='pastaPlot.png';
        print('-dpng', filename);




