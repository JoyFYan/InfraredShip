clc;close all;clear;
I=imread('4.bmp');%��ȡͼƬ
lamda=2;
num=5;%��ֵ����
J=rgb2gray(I);%�ҶȻ�
%I=myhistf( J,1.5,600 );
% subplot(211)
figure (1)
imshow(I)

set(gca,'looseInset',[0 0 0 0])
hold on
[m,n]=size(J);

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
   Gy(i,:)=(double(J(i,:))-double(J(i+1,:)));%�����ݶȼ���
end
gradienty=sum(Gy,2);%ÿ���ݶ����
% subplot(212)
figure (2)
bar(gradienty)
axis([0 240 -2000 2000]) 
title('���ۼӽ��')
xlabel('�к�')
ylabel('�ݶȻҶȺ�')
gdata=zeros(num,7);%�������۾���
[gdata(:,2),gdata(:,1)]=findpeaks(gradienty,'NPeaks',num,'SortStr','descend');%��������1���ݶȺͼ�ֵ
% hold on
% % for i=1:4
%     plot(gdata(:,1),gdata(:,2),'ro')

for i=1:num
   gdata(i,3)=length(find(gradienty(1:gdata(i,1))<0))/gdata(i,1);%��������2���䰵����
   gdata(i,4)=sum(1:gdata(i,1));%��������3���ܱ仯��
   gdata(i,5)=abs(mean(mean(J(1:gdata(i,1),:)))-mean(mean(J(gdata(i,1)+1:m,:))));%��������4���������ۻҶȲ�
end


% figure
% bar(gradienty/gdata(1,2))


gdata(:,2)=gdata(:,2)/gdata(1,2);
% hold on
% plot(gdata(:,1),gdata(:,2),'ro')
gdata(:,6)=[5:-1:1]/5;

gdata(:,4)=1-gdata(:,4)/max(gdata(:,4));%��һ��
gdata(:,5)=gdata(:,5)/max(gdata(:,5));%��һ��
gdata(:,7)=gdata(:,2)*0.2+gdata(:,3)+0.8*gdata(:,4)+gdata(:,5)+0.8*gdata(:,6);%���Բ�ͬӰ�����ӣ��õ����
[~,ind]=max(gdata(:,7));
line=gdata(ind,1);
%line=gdata(1);
% subplot(211)
figure (1)
plot([0,n],[line,line],'r-');%���������
figure (3)
colormap(cool)
imagesc(Gy);
axis off

figure
hsum=sum(J,2);
bar(hsum)
title('�лҶ��ۼӽ��')
xlabel('�к�')
ylabel('�лҶȺ�')
