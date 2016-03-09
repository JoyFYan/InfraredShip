clc;clear ;close all;
O=imread('12.bmp');%读取原始图像
O=rgb2gray(O);%转为灰度图
%[ O,~ ] = myhistf( O,1.5,600 );
[M0, N0]=size(O);%读取原始大小
m=3;n=4;%区域大小
%三次分辨率
subplot(223)
imshow(O);
for multi=1:3
    if multi==1
        I=imresize(O,0.25);
    elseif multi==2
        I=imresize(O,0.5);
    else 
        I=O;
    end
    %[ I,~ ] = myhistf( I,1.5,600 );
    subplot(2,2,multi)
    imshow(I,[]);
    I=double (I);
    [M, N]=size(I);%本次操作大小
    new=zeros(M,N);
    sstd=std(std(I));%整体区域方差
    smean=mean(mean(I));%整体区域均值
    for i=ceil(m/2):M-floor(m/2)
        for j=floor(n/2):N-floor(n/2)
           lmat=I(i-1:i+1,j-1:j+2);
           mmean=mean(mean(lmat));
           if(mmean~=0)           
           mstd=std(std(lmat));       
           if(and(mstd>sstd,mmean>smean))
                new(i,j)=1;
           else
              new(i,j)=0;
           end
           end
        end
    end
    new=medfilt2(new);

    new=imresize(new,[M0 N0],'nearest');
    temp=(double(new).*double(O));
    O=temp/max(max(temp)).*double(O);
end
 
 subplot(224)
 imshow(O,[]);