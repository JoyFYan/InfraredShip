clc ;close all;clear;
I=imread('ship.png');%∂¡»°Õº∆¨

J=rgb2gray(I);%ª“∂»ªØ

J=myhistf( J,1,500 );
A=fspecial('average',8);
J=filter2(A,J,'same');
%J=medfilt2(J,[5 5]);
[m,n]=size(J);

Sy=[-1,-1,-1;0,0,0;1,1,1];
Sx=Sy';

D1=conv2(double(I),double(Sy),'same');
D2=conv2(double(I),double(Sx),'same');
D=zeros(m,n);
%D=sqrt(D1.*D1+D2.*D2);
D=max(D1,D2);
figure,imshow(D,[]);
%t=max(max(D));
a=sum(sum(D))/m/n;
th=0;
for i=1:m
    for j=1:n
        th=th+double((D(i,j)-a)^2);
    end
end
R=zeros(m,n);
deta=sqrt(th/(m*n));
th=sqrt(th/(m*n))*sqrt(2*log(m*n));
% for i=1:m
%     for j=1:n
%         if(R(i,j)<th)
%             R(i,j)=0;
%         end
%         if(R(i,j)>th)
%             R(i,j)=255;
%         end
%     end
%     
% end
R=(D>th);
figure,
imshow(R,[])