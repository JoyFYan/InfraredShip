%%均值目标检测
clc ;close all;clear;
I=imread('8.bmp');%读取图片
tempmax=0;%找最大值临时变量
pos=0;%此时灰度位置
hth=500;%连通区域高阈值
lth=10;%连通区域低阈值
khist=1.5;%均衡程度系数
J=rgb2gray(I);%灰度化
[m,n]=size(J);%图像大小
area0=m*n*0.001;
area1=m*n*0.05;
figure(1)
subplot(411)
imshow(J)
title('原始图像')

J=myhistf( J,1.5,600 );
line=myline(J);
subplot(412)
imshow(J)
J(1:uint8(line-floor(m/10)),:)=0;
A=fspecial('average',8);%均值滤波
J=filter2(A,J,'same');

%J=medfilt2(J,[5 5]);

%% 行列均值阈值
threshold=8;%均值阈值
avrm=mean(J,2);%求行平均
avrn=mean(J,1);%求列平均
stdm=std(J,0,2);
stdn=std(J,0,1);
area1=0.05;%高阈值
area0=0.001;%低阈值
areap=0;
times=0;
while or(max(areap)>area1,max(areap)<area0)
for i=1:m
   for j=1:n
%       if  (and((J(i,j)-avrm(i)>threshold), (J(i,j)-avrn(j)>threshold)))
      if  (and((J(i,j)-avrm(i)>threshold), (J(i,j)-avrn(j)>threshold)))
          J(i,j)=1;
      else
          J(i,j)=0;
      end
   end
end
L = bwlabel(J);
stats=regionprops(L);
area= cat(1, stats.Area);

areap=area/m/n;
if length(areap)==0
   areap=0; 
   area=0;
end
if areap>area1
    threshold=threshold-1;
else 
    threshold=threshold+1;
    
end
times=times+1;
end

subplot(413)
imshow(J,[])
title('行列均值结果')
subplot(414)


% L = bwlabel(J);
% stats=regionprops(L);
% area= cat(1, stats.Area);
% ind=find(or(area>hth,area<lth));
% for i=1:length(ind)
%     L(L==ind(i))=0;
% end

% BW2 = bwareaopen(J,50,8);
% IM2 = imclearborder(BW2,8) ;
% imshow(IM2,[])
se = strel('line',10,2);
se1 = strel('square',4);
 BW2= imerode(J,se1);
 %BW2= imerode(BW2,se1);
 BW2 = bwmorph(BW2,'hbreak');
 %BW2 = bwmorph(BW2,'erode',1);

% BW2 = bwmorph(J,'thin',5);
% BW2 = bwmorph(BW2,'erode');


imshow(BW2)
title('腐蚀结果')


% L = bwlabel(BW2);
% stats=regionprops(L);
% area= cat(1, stats.Area);
% ind=find(or(area>hth,area<lth));
% for i=1:length(ind)
%     L(L==ind(i))=0;
% end

figure(2)
imshow(L)
% 
% imshow(L,[])
















%% 傅里叶频域滤波
% figure(2)
% imshow(J)
% figure(1)
% subplot(321)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2+(j-n/2)^2))>10)
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  imshow(abs(log(1+fresult)),[ ]);
%  title('高通滤波器')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(322),imshow(ret);
% title('结果')
% % thresh = graythresh(ret);     %自动确定二值化阈值
% % I2 = im2bw(ret,thresh);
% % figure(3)
% % imshow(I2)
% 
% figure(1)
% subplot(323)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2/(n/1.5)+(j-n/2)^2))>10)%滤除横向低频
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  hpphoto=mat2gray(abs(log(1+fresult)))*255;
%  
%  imshow(hpphoto,[ ]);
%  title('高通滤波器（横向椭圆）')
%  FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% subplot(324),imshow(ret);
%  title('结果')
% subplot(325)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2+(j-n/2)^2/(n/1.5)))>10)%滤除纵向低频
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  imshow(abs(log(1+fresult)),[ ]);
%  title('高通滤波器（纵向椭圆）')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(326),imshow(ret);
% title('结果')
