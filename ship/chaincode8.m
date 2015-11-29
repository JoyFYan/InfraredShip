function [out] = chaincode8(image)
%功能：实现8连通链码
%输入： 二值图像
%输出：链码的结果
n=[0 1;-1 1;-1 0;-1 -1;0 -1;1 -1;1 0;1 1];
%设置标志
flag=1;
%初始输出的链码串为空
cc=[];
%找到起始点
[x y]=find(image==0);
x=min(x);
imx=image(x,:);
y=min(find(imx==0));
first=[x y];
dir=7;
while flag==1
tt=zeros(1,8);
newdir=mod(dir+7-mod(dir,2),8);
for i=0:7
j=mod(newdir+i,8)+1;
tt(i+1)=image(x+n(j,1),y+n(j,2));
end
d=min(find(tt==1));
dir=mod(newdir+d-1,8);
%找到下一个像素点的方向码后补充在链码的后面
cc=[cc,dir];
x=x+n(dir+1,1);y=y+n(dir+1,2);
%判别链码的结束标志
    if ((x==first(1))&&(y==first(2)))
        flag=0;
    end
end
out=cc;

end

