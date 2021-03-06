clear;close all;clc;
k=0.8;
D=35;
I=imread('7.bmp');
figure(3)
imshow(I)
J=rgb2gray(I);
[J, pos]= myhistf( J,1.2,600 );
%J=histeq(J);
[m, n]=size(J);
figure(1);
subplot(221)
imshow(J);
title('原始图像')
r=0;
while(r<0.8)%均值法背景抑制
    E=mean(mean(J));
    J(J<E)=E;
    E=mean(mean(J));
    r=double(length(J(J<=E)))/double(m*n);    
end

% hist_im=imhist(J);
% % subplot(222)
% % bar(hist_im);
% thresh = 255*graythresh(J);     %自动确定二值化阈值
% I2 = J-k*pos*uint8(ones(m,n));
I2=J;
subplot(222)

imshow(I2);
title('自适应阈值')
max=max(max(I2));
I3=double(I2)*255/double(max);


subplot(223)
I3=uint8(I3);

imshow(I3);
title('提高对比度')



subplot(224)
h=sum(I3,2);
bar(h)
title('横向灰度和')

figure(2)
subplot(321)
fd=fftshift(fft2(I3));
%imshow(abs(log(1+fd)),[ ]);
 H=zeros(m,n);
 for i =1:m
     for j=1:n
         dis=sqrt((i-m/2)^2+(j-n/2)^2);
          if(dis>D)%理想高通
              H(i,j)=1;
          end
        %H(i,j)=1/(1+(sqrt(2)+1)*(D/dis))^2;
%             D=sqrt((m-M)^2+(n-N)^2);
%             H(m,n)=exp((-D^2)/(2*(D0)^2));
         
     end
 end
 %imshow(H)
 fresult=H.*fd;
 imshow(abs(log(1+fresult)),[ ]);
 title('高通滤波器')
  FS=H.*fresult;

fr=real(ifft2(ifftshift(FS)));
ret=im2uint8(mat2gray(fr));
subplot(322),imshow(ret);
hpr=ret+J;

title('结果')
% thresh = graythresh(ret);     %自动确定二值化阈值
% I2 = im2bw(ret,thresh);
% figure(3)
% imshow(I2)

figure(2)
subplot(323)
fd=fftshift(fft2(I3));
%imshow(abs(log(1+fd)),[ ]);
 H=zeros(m,n);
 for i =1:m
     for j=1:n
         if((sqrt((i-m/2)^2/(n/1.5)+(j-n/2)^2))>D)%滤除横向低频
             H(i,j)=1;
%             D=sqrt((m-M)^2+(n-N)^2);
%             H(m,n)=exp((-D^2)/(2*(D0)^2));
         end
     end
 end
 %imshow(H)
 fresult=H.*fd;
 imshow(abs(log(1+fresult)),[ ]);
 title('高通滤波器（横向椭圆）')
 FS=H.*fresult;

fr=real(ifft2(ifftshift(FS)));
ret=im2uint8(mat2gray(fr));
subplot(324),imshow(ret);
 title('结果')
subplot(325)
fd=fftshift(fft2(I3));
%imshow(abs(log(1+fd)),[ ]);
 H=zeros(m,n);
 for i =1:m
     for j=1:n
         if((sqrt((i-m/2)^2+(j-n/2)^2/(n/1.5)))>D)%滤除纵向低频
             H(i,j)=1;
%             D=sqrt((m-M)^2+(n-N)^2);
%             H(m,n)=exp((-D^2)/(2*(D0)^2));
         end
     end
 end
 %imshow(H)
 fresult=H.*fd;
 imshow(abs(log(1+fresult)),[ ]);
 title('高通滤波器（纵向椭圆）')
  FS=H.*fresult;

fr=real(ifft2(ifftshift(FS)));
ret=im2uint8(mat2gray(fr));
subplot(326),imshow(ret);
title('结果')
