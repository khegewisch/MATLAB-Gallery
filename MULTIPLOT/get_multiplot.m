function [h] =  get_multiplot(data,lat,lon,X_LABELS,Y_LABELS);
%data -dimensions(lat,lon,xdim,ydim)
%lat
%lon
%X_LABELS ={'X1';'X2';'X3';};
%Y_LABELS ={'Y1';'Y2';'Y3';};
%returns figure handle

        %=================================
        %=================================
        fs=18;  %fontsize
	ff='Luxi Sans'; %font family

        %=================================
	% SETS LAT/LON GRID FOR MAKEMAP PLOTS
        %=================================
        [x y]=meshgrid(lon-360,lat); %lon should be negatives to work with m_grid

        %=================================
	% DRAWS FIGURE WITH GOOD DIMENSIONS
        %=================================
        h=figure(1); 
	NUM_X = length(X_LABELS);
        NUM_Y=length(Y_LABELS);
        set(h,'Position',[1 1 200*NUM_X 200*NUM_Y+100]); 

        %=================================
	% GET COMMON COLORBAR FOR ALL FIGURES
        %=================================
	cmin=min(data(:));
	cmax=max(data(:));


        for xdim=[1:NUM_X];
                for ydim=[1:NUM_Y];
		        %====================================
			% DESIGNATING SUBPLOT
		        %====================================
                        j=xdim+(ydim-1)*NUM_X;
                        %set the spacing to 0 vertically between plots, 
                        h(j) = subaxis(NUM_Y,NUM_X,j,...
                                'SpacingHorizontal',0,'SpacingVertical',0);

		        %====================================
			% GETTING MIN/MAX OF COLORBAR
		        %====================================
                        value = data(:,:,xdim,ydim);

		        %====================================
			% MAKE MAKEMAP PLOT IN SUBPLOT 
		        %====================================
                        makemap(x,y,value,[cmin cmax]);

		        %====================================
			% COLORBAR
		        %====================================
                        %setting the colorbar to vertical or horizontal
                        if(j==NUM_X);
				%COLOR BAR VERTICAL
                                %hh=colorbar('v');
				%COLORBARHEIGHT =0.8; 	%betweeen [0,1]
				%COLORBARWIDTH=0.03;    	%between [0,1]	
				%COLORBARX0=0.92; 	%between[0,1],X of lower left corner
				%COLORBARY0=0.1; 	%between[0,1],Y of lower left corner
                                %set(hh,'position',[COLORBARX0 COLORBARY0 COLORBARWIDTH COLORBARHEIGHT ],'fontsize',fs);
                        elseif(j==NUM_Y*NUM_X);
                                %cbfreeze %this freezes the colorbar on each plot
				%COLOR BAR HORIZONTAL
                                hh=colorbar('h');
				COLORBARHEIGHT =0.02; 	%betweeen [0,1]
				COLORBARWIDTH=0.8;    	%between [0,1]	
				COLORBARX0=0.1; 	%between[0,1],X of lower left corner
				COLORBARY0=0.06; 	%between[0,1],Y of lower left corner
                                set(hh,'position',[COLORBARX0 COLORBARY0 COLORBARWIDTH COLORBARHEIGHT ],'fontsize',fs-2);
				%setcolorbar label 
				set(get(hh,'ylabel'),'string','C','fontsize',fs,'fontname',ff);
				%set(get(hh,'ylabel'),'string','C','fontsize',fs,'fontname',ff,...
				%	'position',[COLORBARX0+COLORBARWIDTH-.07  COLORBARY0+COLORBARHEIGHT+0.04]);
                        end
		        %====================================
			% LABELING ROWS/COLUMNS with X_LABEL,Y_LABEL
		        %====================================
                        if(ydim==1);
                                title(X_LABELS{xdim},'fontsize',fs,'fontname',ff);
                        end
                        if(xdim==1);
                                ylabel(Y_LABELS{ydim},'fontsize',fs,'fontname',ff);
                        end

                end; %ydim
        end %xdim
end %function
