clear;close all;clc;
k=1;
I=imread('4.bmp');
J=rgb2gray(I);
[m n]=size(J);
figure;
imshow(J);
hist_im=imhist(J);
figure ;
bar(hist_im);
thresh = 255*graythresh(J);     %自动确定二值化阈值
%I2 = im2bw(J,thresh);
I2 = J-k*thresh*uint8(ones(m,n));
figure
imshow(I2);
max=max(max(I2))
I3=int16(I2)*255/int16(max);

figure
imshow(uint8(I3));
figure
h=sum(I3,2);
bar(h)