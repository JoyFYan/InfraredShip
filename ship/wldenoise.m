clear;  close all;clc;               

X=imread('4.bmp');            

X=rgb2gray(X);
[M,N]=size(X);
subplot(221);          

imshow(X);             

title('原始图像');                  

% 生成含噪图像并图示

% init=2055615866;       
% 
% randn('seed',init);      

% X=double(X);

% 添加随机噪声

% XX=X+32*randn(size(X));  
XX=imnoise(X,'gaussian',0,0.005);

X=double(X);
XX=double(XX);
mse=sum(sum((X-XX).^2))/(M*N); 
psnr0=10*log10(255^2/mse) 
subplot(222);             

imshow(uint8(XX));              

title(' 含噪图像 ');       

%用小波函数coif2对图像XX进行2层

% 分解

[c,l]=wavedec2(XX,2,'coif2'); 

% 设置尺度向量

n=[1,2];                  

% 设置阈值向量 , 对高频小波系数进行阈值处理

p=[10.28,24.08]; 

nc=wthcoef2('h',c,l,n,p,'s');

% 图像的二维小波重构

X1=waverec2(nc,l,'coif2');   

subplot(223);              

imshow(uint8(X1),[]);                

%colormap(map);            

title(' 第一次消噪后的图像 '); 

%再次对高频小波系数进行阈值处理

mc=wthcoef2('v',nc,l,n,p,'s');
mse=sum(sum((X-X1).^2))/(M*N); 
psnr1=10*log10(255^2/mse) 
% 图像的二维小波重构

X2=waverec2(mc,l,'coif2');  

subplot(224);             

imshow(uint8(X2));               

title(' 第二次消噪后的图像 '); 
mse=sum(sum((X-X2).^2))/(M*N); 
psnr2=10*log10(255^2/mse) 

figure
A=fspecial('average',2);%均值滤波
X3=filter2(A,XX,'same');
imshow(X3,[])
mse=sum(sum((X-X3).^2))/(M*N); 
psnr3=10*log10(255^2/mse) 


wname='bior3.3';
[c,s]=wavedec2(XX,3,wname);
n=[1,2,3];p=[150,120,60];
nc1=wthcoef2('d',c,s,n,p,'s');
nc2=wthcoef2('d',c,s,n,p,'h');
rx1=(waverec2(nc1,s,wname));
mse=sum(sum((X-rx1).^2))/(M*N); 
psnr4=10*log10(255^2/mse) 

rx2=(waverec2(nc2,s,wname));
mse=sum(sum((X-rx2).^2))/(M*N); 
psnr5=10*log10(255^2/mse) 
