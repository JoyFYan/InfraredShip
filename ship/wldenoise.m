clear;  close all;clc;               

X=imread('4.bmp');            

X=rgb2gray(X);
[M,N]=size(X);
subplot(221);          

imshow(X);             

title('ԭʼͼ��');                  

% ���ɺ���ͼ��ͼʾ

% init=2055615866;       
% 
% randn('seed',init);      

% X=double(X);

% ����������

% XX=X+32*randn(size(X));  
XX=imnoise(X,'gaussian',0,0.005);

X=double(X);
XX=double(XX);
mse=sum(sum((X-XX).^2))/(M*N); 
psnr0=10*log10(255^2/mse) 
subplot(222);             

imshow(uint8(XX));              

title(' ����ͼ�� ');       

%��С������coif2��ͼ��XX����2��

% �ֽ�

[c,l]=wavedec2(XX,2,'coif2'); 

% ���ó߶�����

n=[1,2];                  

% ������ֵ���� , �Ը�ƵС��ϵ��������ֵ����

p=[10.28,24.08]; 

nc=wthcoef2('h',c,l,n,p,'s');

% ͼ��Ķ�άС���ع�

X1=waverec2(nc,l,'coif2');   

subplot(223);              

imshow(uint8(X1),[]);                

%colormap(map);            

title(' ��һ��������ͼ�� '); 

%�ٴζԸ�ƵС��ϵ��������ֵ����

mc=wthcoef2('v',nc,l,n,p,'s');
mse=sum(sum((X-X1).^2))/(M*N); 
psnr1=10*log10(255^2/mse) 
% ͼ��Ķ�άС���ع�

X2=waverec2(mc,l,'coif2');  

subplot(224);             

imshow(uint8(X2));               

title(' �ڶ���������ͼ�� '); 
mse=sum(sum((X-X2).^2))/(M*N); 
psnr2=10*log10(255^2/mse) 

figure
A=fspecial('average',2);%��ֵ�˲�
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
