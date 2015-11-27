function [ line ] = myline( input )
%海天线检测
%   
[m,n]=size(input);

num=4;%极值数量
Gy=zeros(m,n);
for i=ceil(m/30):m-ceil(m/30)
   Gy(i,:)=double(input(i,:))-double(input(i+1,:));%纵向梯度计算
end
gradienty=sum(Gy,2);%每行梯度求和
% subplot(212)
% bar(gradienty)
gdata=zeros(num,5);%创建评价矩阵
[gdata(:,2),gdata(:,1)]=findpeaks(gradienty,'NPeaks',num,'SortStr','descend');%评价条件1：梯度极值
for i=1:num
   gdata(i,3)=length(find(gradienty(1:gdata(i,1))<0))/gdata(i,1);%评价条件2：变暗趋势
   gdata(i,4)=sum(1:gdata(i,1));%评价条件3：总变化量
end
gdata(:,2)=gdata(:,2)/gdata(1,2);
gdata(:,4)=1-gdata(:,4)/max(gdata(:,4));
gdata(:,5)=gdata(:,2)*0.8+gdata(:,3)+0.5*gdata(:,4);
[~,ind]=max(gdata(:,5));
line=gdata(ind,1);
% subplot(211)
hold on
 plot([0,n],[line,line],'r-');%绘出海天线

end

