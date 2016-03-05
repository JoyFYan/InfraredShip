clc;clear ;close all;
I=imread('7.bmp');
I=rgb2gray(I);
I=double (I);
[M, N]=size(I);
m=3;
n=4;
new=zeros(m,n);
sstd=std(std(I));
 for i=ceil(m/2):M-floor(m/2)
     for j=floor(n/2):N-floor(n/2)
        lmat=I(i-1:i+1,j-1:j+2);
        mstd=std(std(lmat));
        if(mstd>sstd)
            new(i,j)=0;
        else
            new(i,j)=255;
        end
     end
 end
 new=medfilt2(new);
 imshow(new,[]);