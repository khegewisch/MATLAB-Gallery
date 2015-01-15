%NAME: colorTable.m
%INPUTS: colorTable.mat
%USES: xticklabel_rotate.m (http://www.mathworks.com/matlabcentral/fileexchange/3486-xticklabel-rotate)
%OUTPUTS:colorTable.png
	%=================================
	addpath('/storage/CODE/MATLAB:'); %xticklabel_rotate.m
	%=================================
	%   LOAD DATA
	%=================================
	filename='colorTable.mat';
	load(filename,'data','X_LABELS','Y_LABELS');

	%=================================
	%   MAKE COLOR TABLE PLOT
	%=================================
	get_pcolorplot(data,X_LABELS,Y_LABELS);

	%=================================
	%   SAVE FILE
	%=================================
	filename = 'colorTable.png';
	print(filename,'-dpng');

