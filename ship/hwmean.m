%%��ֵĿ����
clc ;close all;clear;
I=imread('12.bmp');%��ȡͼƬ
tempmax=0;%�����ֵ��ʱ����
k=0.8;
pos=0;%��ʱ�Ҷ�λ��
hth=500;%��ͨ�������ֵ
lth=10;%��ͨ�������ֵ
khist=1.5;%����̶�ϵ��
J=rgb2gray(I);%�ҶȻ�
[m,n]=size(J);%ͼ���С
figure(1)
subplot(411)
imshow(J)
title('ԭʼͼ��')

[J,pos]=myhistf( J,1.5,600 );
line=myline(J);
% %thresh = 255*graythresh(J);     %�Զ�ȷ����ֵ����ֵ����С����Ӱ��
% J = J-k*pos*uint8(ones(m,n));
% max=max(max(J));
% J=double(J)*255/double(max);
% J=uint8(J);
%hophat�任
% se1 = strel('line',8,4);
% J= imopen(J,se1);


r=0;
while(r<0.8)
    E=mean(mean(J));
    J(J<E)=E;
    E=mean(mean(J));
    r=double(length(J(J<=E)))/double(m*n);    
end

subplot(412)
imshow(J)
J(1:uint8(line-floor(m/12)),:)=0;
A=fspecial('average',8);%��ֵ�˲�
J=filter2(A,J,'same');

%J=medfilt2(J,[5 5]);

%% ���о�ֵ��ֵ
threshold=3;%��ֵ��ֵ
avrm=mean(J,2);%����ƽ��
avrn=mean(J,1);%����ƽ��
stdm=std(J,0,2);
stdn=std(J,0,1);
for i=1:m
   for j=1:n
      if  (and((J(i,j)-avrm(i)>threshold), (J(i,j)-avrn(j)>threshold)))
%       if  (and((J(i,j)-avrm(i)>threshold), (J(i,j)-avrn(j)>(stdn(i)/10))))
          J(i,j)=1;
      else
          J(i,j)=0;
      end
   end
end
subplot(413)
imshow(J,[])
title('���о�ֵ���')
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
title('��ʴ���')


L = bwlabel(BW2);
stats=regionprops(L);
area= cat(1, stats.Area);
ind=find(or(area>hth,area<lth));
for i=1:length(ind)
    L(L==ind(i))=0;
end

figure(2)
imshow(L)
% 
% imshow(L,[])
















%% ����ҶƵ���˲�
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
%  title('��ͨ�˲���')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(322),imshow(ret);
% title('���')
% % thresh = graythresh(ret);     %�Զ�ȷ����ֵ����ֵ
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
%          if((sqrt((i-m/2)^2/(n/1.5)+(j-n/2)^2))>10)%�˳������Ƶ
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
%  title('��ͨ�˲�����������Բ��')
%  FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% subplot(324),imshow(ret);
%  title('���')
% subplot(325)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2+(j-n/2)^2/(n/1.5)))>10)%�˳������Ƶ
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  imshow(abs(log(1+fresult)),[ ]);
%  title('��ͨ�˲�����������Բ��')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(326),imshow(ret);
% title('���')
