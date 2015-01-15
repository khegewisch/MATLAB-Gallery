function []=plot_patch(X,Y_TOP,Y_BOTTOM,COLOR, h,TRANS);
%function []=plot_patch(X,Y_TOP,Y_BOTTOM,COLOR, h,TRANS);
%DESCRIPTION: this function shades in the region between the Y_BOTTOM and Y_TOP curves specified
%	      using the color and transparency specified
%INPUTS: 
%	X	=	row vector of the X values
%	Y_TOP	=	row vector of the Y values of the bottom curve
%	Y_BOTTOM=	row vector of the Y values of the top curve
%	COLOR	=	color to use for the filling of the region
%	h	=	handle to the figure
%	TRANS	=	transparency of the patching (decimal number in [0,1], 
%			where 0=fully transparent, 1=opaque.

	patch([X fliplr(X)],[Y_BOTTOM fliplr(Y_TOP)],COLOR, 'linestyle','none','facealpha',TRANS);

end
