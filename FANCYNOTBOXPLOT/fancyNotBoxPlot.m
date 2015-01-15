%NAME: fancyNotBoxPlot.m
%DESCRIPTION: This code will plot 'notBoxPlots'. Note that boxplot in MATLAB will give edges for the 25th/75th percentiles 
%          in the distribution. notBoxPlot gives edges only for the 1st and 2nd standard deviation. This is why 
%  	   it is called 'not a Box Plot'. 
%INPUTS:  fancyBoxPlot.mat
%USES:    rgb.m (http://www.mathworks.com/matlabcentral/fileexchange/24497-rgb-triple-of-color-name--version-2)
%         notBoxPlot.m (http://www.mathworks.com/matlabcentral/fileexchange/26508-notboxplot-alternative-to-box-plots)
%OUTPUTS: fancyNotBoxPlot.png
%Author:  Abby Lute and John Abatzoglou
%===================================

	addpath('/storage/CODE/MATLAB:'); %rgb.m
	addpath('/storage/CODE/MATLAB/notBoxPlot:'); %notBoxplot.m
	%===================================
	%    PARAMETERS
	%===================================
	ms=6; %marker size
	fs=16;%font size
	ff='luxi sans'; %font family name

	%===================================
	%    LOAD DATA
	%===================================
	myFile='fancyNotBoxPlot.mat';
	load(myFile,'DATA');
	%import matrix of data (where each column is one variable/group)

	%if data is not already in a matrix, you can fill a matrix with the right data like this) 
	%load(myFile,'var1','var2','var3','var4'); 
	%DATA=[var1 var2 var3 var4];

	%===================================
	%    DESIGNATE CATEGORIES and SUBCATEGORIES AND X LOCATIONS WHERE THE BOXPLOTS WILL GO
	%===================================
	num_categories=4;
	num_subcats=2;

	%x-location where you want to put the bar plots at (this is overly complex to be general for more subcats)
	%xcoord(1:4)=[1 2 3 4];  %this is what it is 
	xcount=1;
	for j=1:num_categories;
		for i=1:num_subcats;
			xcoord(i+(j-1)*num_subcats) = xcount;
			xcount=xcount+1;
		end;
		xcount =xcount+1; %spacer of 1 xvalue between categories
	end;

	DATA2=DATA(:,1:num_categories*num_subcats); %this makes sure that the data is the right size (might seem redundant)
	XLABELS={'CAT 1';'CAT 2';'CAT 3';'CAT 4';}; %these would be example labels for the categories (would need to be size num_categories)
	%===================================
	%    USE NOTBOXPLOT
	%===================================
	h=notBoxPlot(DATA2,xcoord);

	%===================================
	%    MODIFY COLORINGS IN NOTBOXPLOT
	%===================================
	%you have to tailor the colors to what you want

        %here is a simple method to color plot
        %d=[h.data];
        %DOT_COLOR={'Blue';'Magenta'};
        %set(d(1:2:end),'markerfacecolor',rgb(DOT_COLOR{1}),'color',rgb(DOT_COLOR{1})); %odds
        %set(d(2:2:end),'markerfacecolor',rgb(DOT_COLOR{2}),'color',rgb(DOT_COLOR{2}))  %evens


	%here is a more complex method to color plot (colors for 8 bins)
	%color of dots
	DOT_COLOR={'Moccasin';'Gainsboro';'BurlyWood';'LightSeaGreen';'Turquoise';'Coral';'CornflowerBlue';'LightCoral';};
	%color of the bar for the mean
	MEAN_COLOR={'PeachPuff';'Silver';'SandyBrown';'MediumSeaGreen';'SteelBlue';'Maroon';'Blue';'Crimson';};
	%color of the region for the first standard deviation from the mean
	FIRSTDEV_COLOR={'Pink';'DarkGray';'Wheat';'PaleGreen';'LightSkyBlue';'Orange';'DodgerBlue';'MediumVioletRed';}; 
	%color of the region for the second standard deviation from the mean
	SECONDDEV_COLOR={'Lavender';'Lavender';'LightBlue';'LightBlue';'White';'White';'White';'White'};
	%note: if you don't want the second dev region to be shown, you can turn that off by coloring it 'white'


	 for k=1:num_categories
	    for i=1:num_subcats;
		    set(h((k-1)*num_subcats+i).data,'markerfacecolor',rgb(DOT_COLOR{(k-1)*num_subcats+i}),...
				'MarkerEdgeColor',rgb(DOT_COLOR{(k-1)*num_subcats+i}),'MarkerSize',ms);
		    set(h((k-1)*num_subcats+i).mu,'color',rgb(MEAN_COLOR{(k-1)*num_subcats+i}));
		    set(h((k-1)*num_subcats+i).semPtch,'facecolor',rgb(FIRSTDEV_COLOR{(k-1)*num_subcats + i}));
		    set(h((k-1)*num_subcats+i).sdPtch,'facecolor',rgb(SECONDDEV_COLOR{(k-1)*num_subcats+i}));
	    end
	end
	hold on

	%===================================
 	%   PLOT SOME HORIZONTAL LINES FOR REFERENCE	
	%===================================
	%plot the zero line
	plot([-1 max(xcoord)+4],[2 2],'color','k')
	%plot lines at  some other y values
	for lev=1:4;
	    plot([-1 max(xcoord)+4],[lev lev],'k:')
	end
	
	%===================================	
	% CHANGE X LABELS	
	%===================================
	set(gca,'XTick',xcoord([1:num_subcats:end])+.5,... %these are x locations for where you want to put labels
		'XLim',[xcoord(1)-.5 xcoord(num_categories*num_subcats)+.5],...
		'XTickLabel',XLABELS,'fontsize',fs,'fontname',ff);

	%===================================
	%    CHANGE Y LABELS
	%===================================
	%Change the Yticks and label them with percentages
	set(gca,'YTick',[0:1:4],'YTickLabel',{'-2%','-1%','0%','+1%','+2%'})

	%label y axis
	ylabel('Leading','fontsize',fs,'fontname',ff);

	set(gca,'fontsize',fs,'fontname',ff);
	box on;

	%===================================
	%    SAVE FIGURE
	%===================================
	set(gcf,'paperPositionMode','auto');
	filename='fancyNotBoxPlot.png';
	print(filename,'-dpng');
