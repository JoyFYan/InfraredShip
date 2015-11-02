clc ;close all;clear;
I=imread('gra.png');%¶ÁÈ¡Í¼Æ¬
lamda=2;
J=rgb2gray(I);%»Ò¶È»¯

I=myhistf( J,1,500 );

[m,n]=size(I);

Sy=[-1,-1,-1;1,1,1];
Sx=Sy';
Syn=[1,1,1;-1,-1,-1];
Sxn=Sy';

Dyp=abs(conv2(double(I),double(Sy),'same'));
Dxp=abs(conv2(double(I),double(Sx),'same'));
% Dyn=conv2(double(I),double(Syn));
% Dxn=conv2(double(I),double(Sxn));


%D=sqrt(D1.*D1+D2.*D2);
%D=max(abs(Dyp),abs(Dxp));
avrx=mean(mean(Dxp(3:m-2,3:n-2)));
stdx=std(std(Dxp(3:m-2,3:n-2)));
avry=mean(mean(Dyp(3:m-2,3:n-2)));
stdy=std(std(Dyp(3:m-2,3:n-2)));
thx=avrx-lamda*stdx;
thy=avry-lamda*stdy;
Dx=zeros(m,n);
Dx(Dxp>thx)=1;
Dy=zeros(m,n);
Dy(Dxp>thy)=1;
C=and(Dx,Dy);
%Dx(Dxp>thx)=0;
% for i=1:m
%     for j=1:n
%         if(D(i,j)>avrxm)
%     end
% end
figure
subplot(211)
imshow(Dx)
subplot(212)
imshow(Dy)


% figure,imshow(Dx,[]);
% %t=max(max(D));
% ret=im2uint8(mat2gray(Dx));
% level = graythresh(ret);
% i2=im2bw(ret,0.07);

