function [ output,pos ] = myhistf( input,khist,lowgray )
%˫��ֱ��ͼ����
%   �˴���ʾ��ϸ˵��

[m,n]=size(input);
tempmax=0;
pos=0;
h=imhist(input);
b=find(h>(lowgray), 1, 'last' );%�ҵ����Ĳ�Ϊ��ֵ�ĻҶ�λ��
c=find(h>(lowgray) , 1 );%�ҵ���С�Ĳ�Ϊ��ֵ�ĻҶ�λ��
k=zeros(1,256);
k0=zeros(1,256);
for i=c+1:256%�������б��
   k(i)=(h(i)-h(c))/(i-c); 
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
% title('�Ľ��Ҷ�ֱ��ͼ����')
% h0=imhist(output);%����ֱ��ͼ
% subplot(326)
% bar(h0)%����ֱ��ͼ
% title('�Ҷ�ֱ��ͼ���')



%%ԭ��
% [m,n]=size(input);
% tempmax=0;
% pos=0;
% h=imhist(input);
% b=find(h>(lowgray), 1, 'last' );%�ҵ����Ĳ�Ϊ��ֵ�ĻҶ�λ��
% c=find(h>(lowgray) , 1 );%�ҵ���С�Ĳ�Ϊ��ֵ�ĻҶ�λ��
% k=zeros(1,256);
% k0=zeros(1,256);
% for i=c:256%�������б��
%    k(i)=(h(i)-h(c))/(i-c); 
% end
% [~,locMp]=max(k);%�ҵ����ֵ��λ��
% Mp=h(locMp);
% for i=1:b-1%�������б��
%    k0(i)=-(h(i)-h(b))/(i-b); 
% end
% [~,locNp]=max(k0);%�ҵ����ֵ��λ��
% Np=h(locNp);
% kl=(Np-Mp)/(locNp-locMp);%Lб��
% 
% for i=locMp:locNp
%     L=Mp+kl*(i-locMp);
%    rd=abs(L-h(i));
%    if rd>tempmax
%        tempmax=rd;
%        pos=i;
%    end
% end
% const1=log( (pos/khist+1))/pos;%����ָ��ϵ��
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
% title('�Ľ��Ҷ�ֱ��ͼ����')
% subplot(122)
% h0=imhist(output);%����ֱ��ͼ
% bar(h0)
% title('ֱ��ͼ')
% end

