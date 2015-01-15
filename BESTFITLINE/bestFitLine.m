%DESCRIPTION: Code for loading in data from several .mat files, getting a best fit line over
%a portion of the data and plotting the figure bestFitLine.png
%
%INPUTS: .mat file bestFitLine.mat
%OUTPUTS: figure bestFitLine.png is saved
%
	%====================================
	%    LOAD DATA
	%====================================
	%load in annual temperature(annualtas) and years
	load('bestFitLine.mat','annualtas','years');

	%====================================
	%    FIND BEST FIT LINE
	%====================================
	targ_years=[2005:2099];
	p=polyfit(targ_years, annualtas(targ_years-1950+1),1);

	%====================================
	%    PLOT DATA
	%====================================
	plot([1950:2099], annualtas,'LineWidth',2); hold on;
	plot(targ_years,p(1)*targ_years+p(2),'r','LineWidth',3);

	%font size and family
	fs=18; %font size
	ff='luxi sans'; %font name 

	%set x/y labels and title for figure
	ylabel('Temperature (deg C)','fontsize',fs,'fontname',ff);
	xlabel('Years','fontsize',fs,'fontname',ff);
	title('Avg Temperature of Moscow, ID under RCP4.5','fontsize',fs,'fontname',ff);

	%properties of text on 'current axes'
	set(gca,'fontsize',fs,'fontname',ff);

	%====================================
	%   SAVE FIGURE 
	%====================================
	filename=['bestFitLine.png'];
	print('-dpng', filename);


