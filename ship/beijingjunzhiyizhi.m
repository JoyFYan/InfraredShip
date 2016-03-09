clear;close all;clc;
I=imread('lowd.png');
J=rgb2gray(I);
r=0;
[m, n]=size(J);

while(r<0.8)
    E=mean(mean(J));
    J(J<E)=E;
    E=mean(mean(J));
    r=double(length(J(J<=E)))/double(m*n);    
end
r=0;
% J(J<=E)=0;
% J(J>E)=255;
subplot(211)
%J(J<=E)=0;
[J, pos]= myhistf( J,1.5,600 );
imshow(J)
% Ji=255-J;
subplot(212)
% imshow(Ji)
% BW1 = edge(J,'canny',0.4);  % µ÷ÓÃcannyº¯Êý
% figure,imshow(BW1); 
% imcontour(J,4)
