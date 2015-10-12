clear;close all;clc;
I=imread('4.bmp');
J=rgb2gray(I);
[m n]=size(J);
figure;
imshow(J);
thresh = graythresh(J);     %自动确定二值化阈值
%I2 = im2bw(J,thresh);
I2 = J-255*thresh*uint8(ones(m,n));
figure
imshow(I2);
max=max(max(I2))
I3=int16(I2)*255/int16(max);
figure
imshow(uint8(I3));
