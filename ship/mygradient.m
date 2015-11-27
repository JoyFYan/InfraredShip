clc;close all;clear;
I=imread('4.bmp');%读取图片
lamda=2;
num=4;%极值数量
J=rgb2gray(I);%灰度化
%I=myhistf( J,1.5,600 );
subplot(211)
imshow(I)
hold on
[m,n]=size(I);

% Sy=[-1,-1,-1;1,1,1];
% Sx=Sy';
% Syn=[1,1,1;-1,-1,-1];
% Sxn=Sy';
% 
% Dyp=(conv2(double(I),double(Sy),'same'));
%Dxp=(conv2(double(I),double(Sx),'same'));
%gradienty=sum(Dyp(ceil(m/30):m-ceil(m/30),:),2);
Gy=zeros(m,n);
for i=ceil(m/30):m-ceil(m/30)
   Gy(i,:)=double(I(i,:))-double(I(i+1,:));%纵向梯度计算
end
gradienty=sum(Gy,2);%每行梯度求和
subplot(212)
bar(gradienty)
gdata=zeros(num,5);%创建评价矩阵
[gdata(:,2),gdata(:,1)]=findpeaks(gradienty,'NPeaks',num,'SortStr','descend');%评价条件1：梯度极值
for i=1:num
   gdata(i,3)=length(find(gradienty(1:gdata(i,1))<0))/gdata(i,1);%评价条件2：变暗趋势
   gdata(i,4)=sum(1:gdata(i,1));%评价条件3：总变化量
end
gdata(:,2)=gdata(:,2)/gdata(1,2);
gdata(:,4)=1-gdata(:,4)/max(gdata(:,4));
gdata(:,5)=gdata(:,2)*0.8+1*gdata(:,3)+1*gdata(:,4);
[~,ind]=max(gdata(:,5));
line=gdata(ind,1);
subplot(211)
plot([0,n],[line,line],'r-');%绘出海天线