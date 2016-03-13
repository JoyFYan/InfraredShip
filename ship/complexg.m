clc;clear ;close all;
I=imread('12.bmp');
[m,n,o]=size(I);
if o~=1
    I=rgb2gray(I);
end
%I=imresize(I,0.5);
I=bgreduction(I,0.6);
subplot(221)
imshow(I)
temp=[1j+1,1,-1j+1;
        1j,0,-1j;
      1j-1,-1,-1j-1];
%temp=temp';
%cg=conv2(double(I),temp,'same');
cg=filter2(temp,double(I),'valid');
x=fix(real(cg));
x(x>200)=0;
xmax=max(max(x));
y=fix(imag(cg));
 y(y>200)=0;
ymax=max(max(y));

% y(y<5)=0;
% y=y/10;
subplot(222)
imshow(abs(x),[])
colormap(hot)
subplot(223)
imshow(abs(y),[])
cga=abs(cg);
subplot(224)
imshow(cga,[])
k=0;
res=zeros(m,n);
for i=5:m-5
    for j=5:n-5        
            if or(abs(x(i,j))>xmax/3,abs(y(i,j))>ymax/3)
%              if k>2
%                 k=0;
%                 else 
%                 k=k+1;
%                 break;
%              end
%             hold on
            if x>0
               if y>0
                   res(i+2,j+2)=255;
               else
                   res(i+2,j-2)=255;
               end
            else
                if y>0
                    res(i-2,j+2)=255;
                else
                    res(i-2,j-2)=255;
                end
            end
            %res(i+floor(x(i,j)),j+floor(y(i,j)))=255;
%             res[j,i],[j+y(i,j),i+x(i,j)],'r','0.3',1)
            end
      
    end
end

figure
imshow(res,[])
