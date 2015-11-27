function [ output,pos ] = myhistf( input,khist,lowgray )
%双向直方图均衡
%   此处显示详细说明

[m,n]=size(input);
tempmax=0;
pos=0;
h=imhist(input);
b=find(h>(lowgray), 1, 'last' );%找到最大的不为阈值的灰度位置
c=find(h>(lowgray) , 1 );%找到最小的不为阈值的灰度位置
k=zeros(1,256);
k0=zeros(1,256);
for i=c+1:256%正向计算斜率
   k(i)=(h(i)-h(c))/(i-c); 
end
[~,locMp]=max(k);%找到最大值与位置
Mp=h(locMp);
for i=1:b-1%反向计算斜率
   k0(i)=-(h(i)-h(b))/(i-b); 
end
[~,locNp]=max(k0);%找到最大值与位置
Np=h(locNp);
kl=(Np-Mp)/(locNp-locMp);%L斜率

for i=locMp:locNp
    L=Mp+kl*(i-locMp);
   rd=L-h(i);
   if rd>tempmax
       tempmax=rd;
       pos=i;
   end
end

const1=log( (pos/khist+1))/pos;%计算指数系数
const2=9/(255-pos);
const3=1-pos*const2;
J0=double(input);
for i=1:m
    for j=1:n
        if J0(i,j)<=pos
            J0(i,j)=floor(exp((J0(i,j)*const1))-1);
        else 
           J0(i,j)=pos/khist+(255-pos/khist)*log10((const2*J0(i,j)+const3));
        end
    end
end
output=uint8(J0);
% subplot(325)
% imshow(output,[])
% title('改进灰度直方图均衡')
% h0=imhist(output);%计算直方图
% subplot(326)
% bar(h0)%绘制直方图
% title('灰度直方图结果')



%%原版
% [m,n]=size(input);
% tempmax=0;
% pos=0;
% h=imhist(input);
% b=find(h>(lowgray), 1, 'last' );%找到最大的不为阈值的灰度位置
% c=find(h>(lowgray) , 1 );%找到最小的不为阈值的灰度位置
% k=zeros(1,256);
% k0=zeros(1,256);
% for i=c:256%正向计算斜率
%    k(i)=(h(i)-h(c))/(i-c); 
% end
% [~,locMp]=max(k);%找到最大值与位置
% Mp=h(locMp);
% for i=1:b-1%反向计算斜率
%    k0(i)=-(h(i)-h(b))/(i-b); 
% end
% [~,locNp]=max(k0);%找到最大值与位置
% Np=h(locNp);
% kl=(Np-Mp)/(locNp-locMp);%L斜率
% 
% for i=locMp:locNp
%     L=Mp+kl*(i-locMp);
%    rd=abs(L-h(i));
%    if rd>tempmax
%        tempmax=rd;
%        pos=i;
%    end
% end
% const1=log( (pos/khist+1))/pos;%计算指数系数
% const2=9/(255-pos);
% const3=1-pos*const2;
% J0=double(input);
% for i=1:m
%     for j=1:n
%         if J0(i,j)<=pos
%             J0(i,j)=floor(exp((J0(i,j)*const1))-1);
%         else 
%            J0(i,j)=pos/khist+(255-pos/khist)*log10((const2*J0(i,j)+const3));
%         end
%     end
% end
% output=uint8(J0);
% figure(2)
% subplot(121)
% imshow(output,[])
% title('改进灰度直方图均衡')
% subplot(122)
% h0=imhist(output);%计算直方图
% bar(h0)
% title('直方图')
% end

