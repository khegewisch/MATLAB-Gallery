function makemap(x,y,data,values);

%adjust data... since pcolor will cut off the edges
%data(size(data,1)+1,:)=NaN;
%data(:,size(data,2)+1)=NaN;

cla;
%m_proj('miller','lat',[32 35],'lon',[-120 -115]);
% m_proj('miller','lat',[30.5 49],'lon',[-125 -105]);
% m_proj('miller','lat',[min(y(:)) 49],'lon',[min(x(:)) max(x(:))]);
 m_proj('miller','lat',[min(y(:)) max(y(:))],'lon',[min(x(:)) max(x(:))]);
% m_proj('miller','lat',[32 42.5],'lon',[-125 -114]);
% [a,b]=m_etopo2('contour',[250:250:3000]);set(b,'color',[.2 .2 .2]);
% m_proj('lambert','long',[-133 -108],'lat',[33 56]);

%m_etopo2('contourf',[250:250:3000]);shading flat;
%set(gca,'climmode','manual','clim',[250 5000]);
%k=colormap(gray);
%for i=1:32 a=k(65-i,:);k(65-i,:)=k(i,:);k(i,:)=a;end
%colormap(k);
%hold on
%m_contour(x,y,data,-values,'--b');
%m_contour(x,y,data,values,'r');
if min(size(x))==1 [x,y]=meshgrid(x,y);end
m_pcolor(x,y,double(data));%,values);
%m_contourf(x,y,data,values);
shading flat;m_grid('xtick',[],'ytick',[]);set(gca,'climmode','manual','clim',[values(1) values(length(values))]);
%set(gca,'climmode','manual','clim',[250 5000]);
%alpha(.1);
hold on
%load /home/abatz/MATLABFILES/usahi
load usahi
for i=1:51
m_plot(stateline(i).long,stateline(i).lat,'k')
end;
set(gcf,'paperpositionmode','auto');
set(gca, 'Box','on');
shading flat
%c=colorbar;set(c,'fontsize',16);
%m_grid('box','off'); %turns bounding box off
