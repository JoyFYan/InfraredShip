clc;close all;clear;
I=imread('sealine.bmp');%��ȡͼƬ
lamda=2;
num=5;%��ֵ����
J=rgb2gray(I);%�ҶȻ�
%I=myhistf( J,1.5,600 );
imshow(J)
figure
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
   Gy(i,:)=double(I(i,:))-double(I(i+1,:));%�����ݶȼ���
end
gradienty=sum(Gy,2);%ÿ���ݶ����
subplot(212)
bar(gradienty)
gdata=zeros(num,7);%�������۾���
[gdata(:,2),gdata(:,1)]=findpeaks(gradienty,'NPeaks',num,'SortStr','descend');%��������1���ݶȺͼ�ֵ
for i=1:num
  % gdata(i,3)=length(find(gradienty(1:gdata(i,1))<0))/gdata(i,1);%��������2���䰵����
%    gdata(i,4)=sum(1:gdata(i,1));%��������3���ܱ仯��
   gdata(i,4)=abs(mean((J(gdata(i,1)+1:m)))-mean((J(1:gdata(i,1)))));%��������3������ҶȲ�
   gdata(i,5)=abs(mean(abs(gradienty(1:gdata(i,1))))-mean(abs(gradienty(gdata(i,1)+1:m))));%��������4���������ۻҶȲ�
end
gdata(:,2)=gdata(:,2)/gdata(1,2);
gdata(:,4)=gdata(:,4)/max(gdata(:,4));%��һ��
gdata(:,5)=gdata(:,5)/max(gdata(:,5));%��һ��
% gdata(:,6)=[num:-1:1]/num;
gdata(:,6)=linspace(max(gdata(:,2)),min(gdata(:,2)),num);
gdata(:,7)=gdata(:,2)*0.5+0.5*gdata(:,6)+1*gdata(:,4)+gdata(:,5);%���Բ�ͬӰ�����ӣ��õ����

[~,ind]=max(gdata(:,7));
line=gdata(ind,1);



while(or(line<m/15,line>m/15*14))
    gdata(ind,7)=0;
    [~,ind]=max(gdata(:,7));
    line=gdata(ind,1);
end

subplot(211)
plot([0,n],[line,line],'r-');%���������

% figure (3)
% hsum=sum(J,2);
% bar(hsum)
% title('�лҶ��ۼӽ��')
% xlabel('�к�')
% ylabel('�лҶȺ�')
