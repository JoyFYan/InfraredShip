clear;
close all;%'Fig2.22(a).jpg'
a=imread('lowd.png');
a=rgb2gray(a);
[n,m]=size(a);
figure,subplot(121),imshow(a);title('orignial image');
% a=double(a);
% b=zeros(1,9);
% e=zeros(n,m);
% f=zeros(n,m);
% for i=2:(n-1)
%     for j=2:(m-1)
%         b(1,1)=-1+a(i-1,j-1);
%         b(1,2)=-2+a(i-1,j);
%         b(1,3)=-3+a(i-1,j+1);
%         b(1,4)=-4+a(i,j-1);
%         b(1,5)=-5+a(i,j);
%         b(1,6)=-6+a(i,j+1);
%         b(1,7)=-7+a(i+1,j-1);
%         b(1,8)=-8+a(i+1,j);
%         b(1,9)=-9+a(i+1,j+1);
%         min=255;
%         for k=1:9         
%             if b(1,k)<min
%                 min=b(1,k);
%             end
%         end
%         e(i,j)=min;
%     end
% end
% for i=2:(n-1)
%     for j=2:(m-1)
%         b(1,1)=1+e(i-1,j-1);
%         b(1,2)=2+e(i-1,j);
%         b(1,3)=3+e(i-1,j+1);
%         b(1,4)=4+e(i,j-1);
%         b(1,5)=5+e(i,j);
%         b(1,6)=6+e(i,j+1);
%         b(1,7)=7+e(i+1,j-1);
%         b(1,8)=8+e(i+1,j);
%         b(1,9)=9+e(i+1,j+1);
%         max=0;
%         for k=1:9
%             if b(1,k)>max
%                 max=b(1,k);
%             end
%         end
%         f(i,j)=max;
%     end
% end
% c=a-f;
% c=uint8(c);
c = bwmorph(a,'tophat');
subplot(122),imshow(c);title('top-hat');
% [row,column]=size(c);
% g=im2double(c);
% x=1:column; y=1:row; [x,y]=meshgrid(x,y);figure,mesh(x,y,g);
% title('orignial image gray level');