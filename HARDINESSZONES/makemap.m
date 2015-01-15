function makemap(x,y,data,values);

	cla;
	%============
	%set projection of map
	%============
	 m_proj('miller','lat',[min(y(:)) max(y(:))],'lon',[min(x(:)) max(x(:))]);

	%============
	%make map
	%============
	m_pcolor(x,y,double(data));%,values);
	shading flat;m_grid('xtick',[],'ytick',[]);set(gca,'climmode','manual','clim',[values(1) values(length(values))]);
	hold on

	%============
	%   GET USA STATELINES MAP
	%============
	load usahi
	for i=1:51
		m_plot(stateline(i).long,stateline(i).lat,'k')
	end;

	%============
	set(gcf,'paperpositionmode','auto');
	set(gca, 'Box','on');
	shading flat
end
