function [ input ] = bgreduction( input,k )
%input 输入图像 r比例系数
[m, n, o]=size(input);
if(o==3)
    input=rgb2gray(input);
end
r=0;
while(r<k)
    E=mean(mean(input));
    input(input<E)=E;
    E=mean(mean(input));
    r=double(length(input(input<=E)))/double(m*n);    
end
% input(input<=E)=0;
% input(input>E)=255;
%input(input<=E)=0;
%[input,~]= myhistf( input,1.5,600 );
imshow(input,[])
% Ji=255-input;
% imshow(Ji)
% BW1 = edge(input,'canny',0.4);  % 调用canny函数
% figure,imshow(BW1); 
% imcontour(input,4)
