close all;clear all;clc;
I=imread('1 (21).bmp');
[m, n, d]=size(I);
if d==3
    I=rgb2gray(I);
end
figure(1)
subplot(2,3,1)
imshow(I);
max=max(max(I))
for i=1:10
    prompt='Input the gray value:gray=';
    gray=input(prompt);
    if gray==0
       gray=max; 
       for j=0:4
         J=(I==(gray-j));
         subplot(2,3,2+j)
         imshow(J);
       end
    else
        for j=0:4
           J=(I==(gray-j));
          subplot(2,3,2+j)
          imshow(J);
       end
    end
    i=i+1;
end
