clc ;close all;clear;
I=imread('8.bmp');%��ȡͼƬ
tempmax=0;%�����ֵ��ʱ����
pos=0;%��ʱ�Ҷ�λ��
khist=0.5;%����̶�ϵ��
J=rgb2gray(I);%�ҶȻ�
I1=histeq(J);%�Դ�����
figure(1);
subplot(321)
imshow(J)
title('ԭʼͼ��')
subplot(322)
h=imhist(J);
bar(h)
title('ԭʼֱ��ͼ')
subplot(323)
%��ʵԭʼͼ��
Jmat=histeq(J);

imshow(Jmat);
title('�Զ��Ҷ�ֱ��ͼ����')
h=imhist(Jmat);%����ֱ��ͼ

subplot(324)
bar(h)%����ֱ��ͼ
title('�Ҷ�ֱ��ͼ���')
%imshow(h)
[m,n]=size(J);
b=find(h>(m*n/10000), 1, 'last' );%�ҵ����Ĳ�Ϊ��ֵ�ĻҶ�λ��
k=zeros(1,256);
k0=zeros(1,256);
for i=2:256%�������б��
   k(i)=(h(i)-h(1))/(i-1); 
end
[~,locMp]=max(k);%�ҵ����ֵ��λ��
Mp=h(locMp);
for i=1:b-1%�������б��
   k0(i)=-(h(i)-h(b))/(i-b); 
end
[~,locNp]=max(k0);%�ҵ����ֵ��λ��
Np=h(locNp);
kl=(Np-Mp)/(locNp-locMp);%Lб��

for i=locMp:locNp
    L=Mp+kl*(i-locMp);
   rd=L-h(i);
   if rd>tempmax
       tempmax=rd;
       pos=i;
   end
end
const1=log( (pos/khist+1))/pos;%����ָ��ϵ��
const2=9/(255-pos);
const3=1-pos*const2;
J0=double(J);
for i=1:m
    for j=1:n
        if J0(i,j)<=pos
            J0(i,j)=floor(exp((J0(i,j)*const1))-1);
        else 
           J0(i,j)=pos/khist+(255-pos/khist)*log10((const2*J0(i,j)+const3));
        end
    end
end
ret=uint8(J0);
subplot(325)
imshow(ret,[])
title('�Ľ��Ҷ�ֱ��ͼ����')
h0=imhist(ret);%����ֱ��ͼ
subplot(326)
bar(h0)%����ֱ��ͼ
title('�Ҷ�ֱ��ͼ���')
[g,~]=find(h0(1:floor(pos/khist))~=0);%��Ϊ0������