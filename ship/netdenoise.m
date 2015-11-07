X=imread('cameraman.tif');
X=im2double(X);
% nbc=size(map,1);
x=imnoise(X,'gaussian',0,0.005);
wname='bior3.3';
[c,s]=wavedec2(x,3,wname);
n=[1,2,3];p=[150,120,60];
nc1=wthcoef2('d',c,s,n,p,'s');
nc2=wthcoef2('d',c,s,n,p,'h');
rx1=waverec2(nc1,s,wname);
rx2=waverec2(nc2,s,wname);
%[a,b]=psnr_mse(rx1,X);
% colormap(gray(nbc));
subplot(221) ;imageshow(wcodemat(X,[])); title('原图');
subplot(222) ;imageshow(wcodemat(x,[])); title('含方差为0.005的高斯噪声') ;
subplot(223); imageshow(wcodemat(rx1,[])) ;title('小波基bior3.3软阈值去噪') ;
subplot(224) ;imageshow(wcodemat(rx2,[])); title('小波基bior3.3硬阈值去噪') ;

% function [mse,psnr] = psnr_mse(image,image_prime);
% % convert to doubles;
% image=double(image) ;
% [M,N]=size(image) ;
% image_prime=double(image_prime) ;
% % avoid divide by zero nastiness
% if ((sum(sum((image-image_prime).^2))) == 0) ;
% error('Input vectors must not be identical');
% else
% mse=sum(sum((image-image_prime).^2))/(M*N); 
% psnr=10*log10(255^2/mse) ;
% end
% return