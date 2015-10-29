clear all;close all;clc;
I=imread('4.bmp');
J=rgb2gray(I);
figure;
imshow(J);
hist_im=imhist(J);
figure ;
bar(hist_im);
K=J(1:120,:);
hist_im=imhist(K);
figure ;
bar(hist_im);
figure
imshow(K)
