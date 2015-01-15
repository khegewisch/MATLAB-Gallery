function [] = makeClimograph(temp,ppt);

	%============================
	%clear figure for plotting
	%============================
	clf;

	%============================
	% PLOT BAR GRAPH
	%============================
	bar(ppt);

	%============================
	% PLOT BAR GRAPH
	%============================
	xlabel('Month','fontsize',20);
	
	%============================
	% CHANGE XAXIS LABELS TO STRING MONTHS
	%============================
	%one option
	%months = ['Jan';
	%            'Feb';
	%            'Mar';
	%            'Apr';
	%            'May';
	%            'Jun';
	%            'Jul';
	%            'Aug';
	%            'Sep';
	%            'Oct';
	%            'Nov';
	%            'Dec'];
	%set(gca,'xtick',1:12,'XTickLabel',months)

	%another option
	set(gca,'xtick',1:12,'xticklabel','J|F|M|A|M|J|J|A|S|O|N|D');

	set(gca,'fontsize',16);

	%============================
	% SET YLABEL FOR LEFTHAND AXIS
	%============================
	ylabel('Precipitation (mm)','fontsize',20);
	hAxes=gca;
	hAxes_pos=get(hAxes,'Position');
	hAxes2 = axes('Position',hAxes_pos);


	%============================
	% PLOT TEMPERATURE 
	%============================
	plot(temp,'r','LineWidth',3)

	%============================
	% SET YLABEL FOR RIGHTHAND AXIS
	%============================
	ylabel('Temperature (\circC)','fontsize',20);
	set(hAxes2,'YAxisLocation','right','Color','none','XTickLabel',[]);
	h1_xlim=get(hAxes,'XLim');
	set(hAxes2,'XLim',h1_xlim);

	set(gca,'fontsize',16);
end
