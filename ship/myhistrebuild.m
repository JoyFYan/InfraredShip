function [] = myhistrebuild(I,floor)
if nargin==1
       floor=16;
end
[m, n]=size(I);
all=m*n;
eachf=ceil(all/floor);
j=1;last=0;
temp=length(find(I<2));%����������


for i=3:256
    
    if temp>eachf%����
        K=((I>last)&(I<i));
        last=i;
        figure
        [Xset Yset]=find(K==1);
        temp=0;
        
        x=ones(m,1)*[1:n];%?Matrix?with?each?pixel?set?to?its?x?coordinate
        y=[1:m]'*ones(1,n);%???"?????"?????"????"????"??"???"??y????"??
        area=sum(sum(K));
        meanx=sum(sum(double(K).*x))/area;
        meany=sum(sum(double(K).*y))/area;
%         disp('x:')
%         disp(meanx);
%         disp('y:')
        disp([meanx,meany]);
        
        imshow(K);
        hold on
        plot(meanx,meany,'.','markersize',20);
        D = pdist2([Xset Yset],[meanx meany]);
        meanD=mean(D);%ƽ���㷨��
        disp(meanD);
    else 
        temp=temp+length(find((I<i)&(I>last)));
    end
end