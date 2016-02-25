
clc ;close all;clear;
I=imread('18.bmp');%¶ÁÈ¡Í¼Æ¬
I=rgb2gray(I);%»Ò¶È»¯
figure
I=myhistf( I,1.5,600 );
subplot(221)
imshow(I)
se1 = strel('line',8,4);
BW2= imopen(I,se1);
% BW2= imerode(I,se1);
subplot(222)
imshow(BW2)
subplot(223)
r=I-BW2;
[r,pos]=myhistf( r,1.5,600 );
imshow(r,[])
se2 = strel('disk',1);
r=imopen(r,se2);
subplot(224)
pos=50;
r(r>pos)=255;
r(r<=pos)=0;
imshow(r,[])