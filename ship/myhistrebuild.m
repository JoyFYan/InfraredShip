function [] = myhistrebuild(I,floor)

if nargin==0
       floor=16;
       I=imread('4.bmp');
end
if nargin==1
       floor=16;
end
[m, n, v]=size(I);
if v==3
    I=rgb2gray(I);
end
all=m*n;
eachf=ceil(all/floor);
j=1;last=0;num=1;
temp=length(find(I<2));%已有像素数


for i=3:256
    
    if temp>eachf%符合
        K=((I>last)&(I<i));
        last=i;
        figure
        [Xset Yset]=find(K==1);
        temp=0;
        
        x=ones(m,1)*[1:n];%
        y=[1:m]'*ones(1,n);%
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
        sub=max(D)-min(D);
        meanD=mean(D);%平均算法？
        Dres(num)=meanD;
        subres(num)=sub;
        s=std(D,0,1);
        sres(num)=s;
        
        num=num+1;
    else 
        temp=temp+length(find((I<i)&(I>last)));
    end
end
disp(Dres);
disp(subres);
disp(sres);
