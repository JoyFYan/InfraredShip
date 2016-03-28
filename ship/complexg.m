clc;clear ;close all;
J=imread('1.bmp');
[m,n,o]=size(J);
if o~=1
    J=rgb2gray(J);
end
% I=imnoise(J,'gaussian',0,0.000012);
I=J;
% ERMS = erms(I, J);
MES=sum(sum((I-J).^2))/(m*n);     %均方差
PSNR=20*log10(255/sqrt(MES));
%  [I,pos]=myhistf( I,1.5,600 );
% I=imresize(I,0.5);
% line=myline(I);
% I(1:uint8(line-floor(m/12)),:)=0;
% I=bgreduction(I,0.01);
subplot(221)
imshow(I)

title('（a）原始图像')
temp=[3j+3,10,-3j+3;
        10j,0,-10j;
      3j-3,-10,-3j-3];
%   temp=[1j+1,2,-1j+1;
%         2j,0,-2j;
%       1j-1,-2,-1j-1];
%temp=temp';
%cg=conv2(double(I),temp,'same');
tic
cg=filter2(temp,double(I),'valid');
x=(real(cg));
%x(x>200)=0;
xmax=max(max(x));
y=(imag(cg));
% y(y>200)=0;
ymax=max(max(y));

% y(y<5)=0;
% y=y/10;
subplot(222)

imshow(abs(x),[])
title('（b）垂直梯度')
subplot(223)
imshow(abs(y),[])
title('（c）水平梯度')
cga=abs(cg);
subplot(224)
imshow(cga,[])
title('（d）幅值图像')
k=0;
res=zeros(m,n);
res1=zeros(m,n);
for i=5:m-5
    for j=5:n-5        
            if or(abs(x(i,j))>xmax/3,abs(y(i,j))>ymax/3)
                
                res=plotline(i,j,i-fix(x(i,j)/60),j-fix(y(i,j)/60),res);
                res1(i,j)=1;
%             if x>0
%                if y>0
%                    res(i+2,j+2)=255;                   
%                else
%                    res(i+2,j-2)=255;                   
%                end
%             else
%                 if y>0
%                     res(i-2,j+2)=255;
%                 else
%                     res(i-2,j-2)=255;
%                 end
%             end
            end
      
    end
end
 res(res<6)=0;
  
  
  L = bwlabel(res);
stats=regionprops(L);
area= cat(1, stats.Area);
ind=find(or(area>500,area<4));
for i=1:length(ind)
    L(L==ind(i))=0;
end

se1 = strel('square',2);
 BW2= imdilate(L,se1);
 toc
figure
subplot(121)


imshow(L,[])
subplot(122)
imshow(res1,[])

 figure
 imshow(BW2)

