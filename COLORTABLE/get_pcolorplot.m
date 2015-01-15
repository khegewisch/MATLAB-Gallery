function []=get_pcolorplot(DATA, X_LABELS,Y_LABELS);

	%set fonts
	ff='Arial';
	fs=8;

	%=========================================
	% PAD DATA FOR PLOTTING WITH PCOLOR
	%=========================================
	DATA(size(DATA,1)+1,:)=NaN;
 	DATA(:,size(DATA,2)+1)=NaN;

	%=========================================
	% SET COLORS
	%=========================================
	%set number of colors on colorbar so that there are integer ticks at center of color
	mn =floor(min(DATA(:)));
	mx=ceil(max(DATA(:)));
	rangeValues = mx-mn;
	colorbarTicks=[mn:1:mx];
        numColors =length(colorbarTicks);

	%=========================================
	% PCOLOR PLOT
	%=========================================
	%(note: this transposes the matrix DATA)
	pcolor(DATA');

	%=========================================
	% X,Y LABELS/TICKS
	%=========================================
	set(gca,'XTick',[1:length(X_LABELS)]);
	set(gca,'YTick',[1:length(Y_LABELS)]);
	set(gca,'XTickLabel',X_LABELS);
	set(gca,'YTickLabel',Y_LABELS);
	set(gca,'xtick',1.5:1:length(X_LABELS)+.5);
	set(gca,'ytick',1.5:1:length(Y_LABELS)+.5);
	set(gca,'fontsize',fs,'fontname',ff);
	
	%=========================================
	% WHITE BACKGROUND
	%=========================================
	set(gcf,'color','w');

	%=========================================
	% COLORBAR
	%=========================================
	%add colorbar with colormap 'jet'
	hc=colorbar; 
	colormap(flipud(jet(numColors)));

	%set the ticks and labels on the colorbar
        caxis([min(colorbarTicks)-.5 max(colorbarTicks)+.5]);
        set(hc,'YTick',colorbarTicks);

	%=========================================
	% ROTATE XLABELS
	%=========================================
	xticklabel_rotate(.5+[1:length(X_LABELS)],90,X_LABELS,'interpreter','none')
end
