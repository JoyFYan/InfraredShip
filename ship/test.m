clc;clear ;close all;
I=imread('chain.jpg');%读取图片
tempmax=0;%找最大值临时变量
J=rgb2gray(I);%灰度化
[m,n]=size(J);
% [ out ] = chaincode8(J);
thresh = graythresh(J);     %自动确定二值化阈值
BW = im2bw(J,thresh);       %对图像二值化
figure
subplot(211)
imshow(BW)
% [B,L,N,A] =bwboundaries(I2,'noholes');
% subplot(212)
% imshow(L,[])
%BW = imread('blobs.png');
[B,L,N] = bwboundaries(BW,'noholes');
figure; imshow(BW); hold on;
for k=1:length(B),
    boundary = B{k};
    if(k > N)
        plot(boundary(:,2),...
            boundary(:,1),'g','LineWidth',2);
    else
        plot(boundary(:,2),...
            boundary(:,1),'r','LineWidth',2);
    end
end

%%复数链码
chaincode=cell(length(B));
for k=1:length(B),
    boundary = B{k};
    bl=length(boundary);
    tempcode=zeros(bl,1);
    tempcode(1)=boundary(1,1)-boundary(bl,1)+1i*(boundary(1,2)-boundary(bl,2));
    for len=2:bl
        dx=boundary(len,1)-boundary(len-1,1);
        dy=boundary(len,2)-boundary(len-1,2);
        tempcode(len)=dx+1i*dy;          
    end
    chaincode{k}=tempcode;%第一部分复数链码
    
    tempcode(1)=chaincode{k}(1,1)-chaincode{k}(bl,1);
    for len=2:bl
        tempcode(len)=chaincode{k}(len,1)-chaincode{k}(len-1,1);
        %tempcode(len)=dx+1i*dy;          
    end
    chaincode{k}(:,2)=tempcode;%相减码
    
   
    
    chaincode{k}(1,3)=real(chaincode{k}(1,1));
    chaincode{k}(1,4)=imag(chaincode{k}(1,1));
    for len=2:bl
        chaincode{k}(len,3)=chaincode{k}(len-1,3)+real(chaincode{k}(len,1));
        chaincode{k}(len,4)=chaincode{k}(len-1,4)+imag(chaincode{k}(len,1));
        %tempcode(len)=dx+1i*dy;
    end
    figure
    plot(chaincode{1}(:,3));
    hold
    plot(chaincode{1}(:,4));
end
