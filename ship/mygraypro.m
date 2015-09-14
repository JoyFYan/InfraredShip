function [] = mygraypro(I)

if nargin==0
       I=imread('4.bmp');
end
[m, n, v]=size(I);
if v==3
    I=rgb2gray(I);
end
[con,x]=imhist(I);
figure(1)
subplot(1,3,1)
imshow(I);
subplot(1,3,2)
bar(x,con);

all=m*n;
K=uint8(zeros(30,320,8));
figure(2)
for i=1:8
    K(:,:,i)=I(((1+(i-1)*30):i*30),:);
    temphist=imhist(K(:,:,i));
    subplot(4,4,i)
    imshow(K(:,:,i));
    subplot(4,4,i+8)
    bar(temphist)
end
for i=1:255
    temp=length(find(I==i));
end