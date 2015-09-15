function [] = mygraypro(I)

if nargin==0
       I=imread('1.bmp');
end
[m, n, v]=size(I);
if v==3
    I=rgb2gray(I);
end
x0=(1:256)';
all=m*n;
[con,x]=imhist(I);
conre=con/all;
figure(1)
subplot(1,3,1)
imshow(I);
subplot(1,3,2)
bar(x,con);
mycreateFit(x0, conre);

K=uint8(zeros(30,320,8));
figure(2)
for i=1:8
    K(:,:,i)=I(((1+(i-1)*30):i*30),:);
    temphist=imhist(K(:,:,i));
    figure(2)
    subplot(4,4,i)
    imshow(K(:,:,i));
    figure(2)
    subplot(4,4,i+8)
    bar(temphist)
    
    temphistre=temphist/30/320;
    mycreateFit(x0, temphistre);
    tempsub=conre-temphistre;
    subres(i)=sum(abs(tempsub));
end
% for i=1:255
%     temp=length(find(I==i));
% end
[val ind]=min(subres)
lvl=graythresh(K(:,:,ind));
R=im2bw(K(:,:,ind),lvl);
figure
imshow(R);
