function [h,hc] = plot_stationPoints(x,y,VALUES,numColors,markerSize,mn,mx,colorbarTicks);

	%set values outside the limits to the limits
	f=find(VALUES>mx);VALUES(f)=mx;

	f=find(VALUES<mn);VALUES(f)=mn;

	%create the index of the color to assign each value
	rangeValues =mx-mn;
	ind_COLOR = floor( (VALUES-mn)/rangeValues *(numColors-1)+1 );

	%set colormap for colorbar
	COLORS = colormap(jet(numColors));

	%set the projection
	m_proj('miller','lat',[min(y(:)) max(y(:))],'lon',[min(x(:)) max(x(:))]);

	%plot one point for each station location
	for s=1:length(VALUES);
		 h=m_plot(x(s),y(s),'o');
		 set(h,'markersize',markerSize,'markerfacecolor',...
			      COLORS(ind_COLOR(s),:),'markeredgecolor','k');
		hold on;
	end

	%make the colorbar
	hc=colorbar;

	%set the range on the colorbar
	caxis([mn mx]);

end

