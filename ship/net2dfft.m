close all ;clear
%f=[1:4;5:8;9:12;13:16]
f=imread('4.bmp');
f=rgb2gray(f);
 figure(1)
%f=[1:5;6:10;11:15;16:20;21:25]
subplot(2,2,1),imshow(f,[]);
[M,N]=size(f);
M=M/2;
N=N/2;
%二维傅里叶变换
F=fft2(f);
FS=fftshift(F);

%频谱
S=log(1+abs(FS));
subplot(2,2,3);imshow(S,[]);
figure(2)
imshow(S,[]);
% 二维傅里叶逆变换
  H=ones(2*M,2*N);
 H(1:100,155:165)=0;
 H(100:240,155:165)=0;

 FS=H.*FS;
 figure(1)
  subplot(2,2,2),imshow(log(1+abs(FS)),[]);
fr=real(ifft2(ifftshift(FS)));
ret=im2uint8(mat2gray(fr));
subplot(2,2,4),imshow(ret);
figure(3)
imshow(ret)

