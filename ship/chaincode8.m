function [out] = chaincode8(image)
%���ܣ�ʵ��8��ͨ����
%���룺 ��ֵͼ��
%���������Ľ��
n=[0 1;-1 1;-1 0;-1 -1;0 -1;1 -1;1 0;1 1];
%���ñ�־
flag=1;
%��ʼ��������봮Ϊ��
cc=[];
%�ҵ���ʼ��
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
%�ҵ���һ�����ص�ķ�����󲹳�������ĺ���
cc=[cc,dir];
x=x+n(dir+1,1);y=y+n(dir+1,2);
%�б�����Ľ�����־
    if and((x==first(1)),(y==first(2)))
        flag=0;
    end
end
out=cc;

end

