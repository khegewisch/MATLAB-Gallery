%NAME: multiplot.m
%INPUTS: multiplot.mat
%USES: subaxis (http://www.mathworks.com/matlabcentral/fileexchange/3696-subaxis-subplot)
%      m_map(http://www2.ocgy.ubc.ca/~rich/map.html)
%      export_fig (export_fig.m (http://www.mathworks.com/matlabcentral/fileexchange/42012-figuremaker-publication-quality-figures-with-matlab/content/figuremaker/export_fig/export_fig.m)

%OUTPUTS:multiplot.png
        %=================================
        addpath('/storage/CODE/MATLAB:'); 	     %subaxis.m
        addpath('/storage/CODE/MATLAB/JOHNSMATLAB/m_map:');
	addpath('/storage/CODE/MATLAB/export_fig:'); %export_fig.m 
        %=================================
        %   LOAD DATA
        %=================================
        filename='multiplot.mat';
        load(filename,'data','lat','lon','X_LABELS','Y_LABELS'); %data(lat,lon,xdim,ydim)

        %=================================
        %   MAKE COLOR TABLE PLOT
        %=================================
        h=get_multiplot(data,lat,lon,X_LABELS,Y_LABELS);

        %====================================
        % SAVE FIGURE WITH EXPORT_FIG
        %====================================
        %export_fig is nice in that it prints to a file exactly that which is in the figure window(to get what you see)

        %notice that currently the numbers on the colorbar are cut off
        %fix this by manually stretching the figure window until you can see the numbers and you have a 
        %graph you like (you can squish out all the space between the graphs this way too)
        %then call this function to get the 4-tuple representing the size of the window
        %WINDOWSIZE=get(gcf,'position'); %this will look something like [ 619         802        1032         356]

	%this is what I got by stretching the window until it looked ok
        WINDOWSIZE =[889   339   617   558];

        %now set the window size to be this (and maybe uncomment out the above WINDOWSIZE command) 
        set(gcf,'color','w','position',WINDOWSIZE);
        export_fig('multiplot.png','-a2'); %this saves the figure to an A2 size paper format (I think)

