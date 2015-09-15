function [] = myfilter(I)
if nargin==0
       I=imread('4.bmp');
end

[m, n, v]=size(I);
if v==3
    I=rgb2gray(I);
end

figure
imshow(I);

