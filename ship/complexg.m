clc;clear ;close all;
I=imread('bsmj.jpg');
[m,n,o]=size(I);
if o~=1
    I=rgb2gray(I);
end
%I=imresize(I,0.5);
% I=bgreduction(I,0.01);
subplot(221)
imshow(I)
title('（a）原始图像')
temp=1/3*[3j+3,10,-3j+3;
        10j,0,-10j;
      3j-3,-10,-3j-3];
%   temp=[1j+1,2,-1j+1;
%         2j,0,-2j;
%       1j-1,-2,-1j-1];
%temp=temp';
%cg=conv2(double(I),temp,'same');
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
            if or(abs(x(i,j))>xmax/1.5,abs(y(i,j))>ymax/1.5)
                
                res=plotline(i,j,i-fix(x(i,j)/20),j-fix(y(i,j)/20),res);
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
%res(res<2)=0;
figure
subplot(121)
imshow(res,[])
subplot(122)
imshow(res1,[])