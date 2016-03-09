clc;clear ;close all;
I=imread('4.bmp');
I=rgb2gray(I);
J=I;
[M0, N0]=size(I);
I=imresize(I,0.5);
%[ I,~ ] = myhistf( I,1.5,600 );
subplot(311)
imshow(I);
I=double (I);
[M, N]=size(I);
m=3;
n=4;
new=zeros(M,N);
sstd=std(std(I));
smean=mean(mean(I));
 for i=ceil(m/2):M-floor(m/2)
     for j=floor(n/2):N-floor(n/2)
        lmat=I(i-1:i+1,j-1:j+2);
        mstd=std(std(lmat));
        mmean=mean(mean(lmat));
        if(and(mstd>sstd,mmean>smean))
            new(i,j)=1;
        else
            new(i,j)=0;
        end
     end
 end
 new=medfilt2(new);
 new=uint8(imresize(new,[M0 N0],'nearest'));
 new=new.*J;
 subplot(312)
 imshow(new,[]);

 
 I=double(new);
 new=zeros(m,n);
sstd=std(I(I>10));
smean=mean(I(I>10));
I(I<smean)=0;
 for i=ceil(m/2):M0-floor(m/2)
     for j=floor(n/2):N0-floor(n/2)
        lmat=I(i-1:i+1,j-1:j+2);
        mstd=std(std(lmat));
        mmean=mean(mean(lmat));
        if(and(1,mmean>smean))
            new(i,j)=1;
        else
            new(i,j)=0;
        end
     end
 end

  subplot(313)
 imshow(new,[]);
%  SE1=strel('ball',2,2);
% eroded=imerode(new,SE1,'same'); %erode
% BW2 = bwmorph(eroded,'skel',1);
% subplot(313)
% imshow(BW2,[]);