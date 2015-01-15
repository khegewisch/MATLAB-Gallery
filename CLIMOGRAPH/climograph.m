%climograph.m
%DESCRIPTION: 	This code plot a climograph (a bar chart for avg precipitation and a line plot overlay for avg temperature)
%INPUTS: 	climograph.mat
%USES:		getClimograph.m
%OUTPUTS:	climograph.png

	%================================
	%LOAD DATA
	%================================
	myFile='climograph.mat';
	load(myFile,'tempC','precMM');

	%================================
	%CALCULATE AVERAGE CLIMATOLOGY
	%================================
	avgtemp = nanmean(tempC, 1);
	avgprec=nanmean(precMM,1);

	%================================
	%CALL FUNCTION TO MAKE CLIMOGRPAH
	%================================
	getClimograph(avgtemp,avgprec);
	title('Climograph of Moscow,ID','fontsize',18);

	%================================
	%SAVE FIGURE
	%================================
	%save it manually.. something buggy about saving it like this
	%filename=['climograph.png'];
	%print('-dpng', filename);
