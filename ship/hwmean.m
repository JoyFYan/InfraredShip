clc ;close all;clear;
I=imread('ship.png');%��ȡͼƬ
tempmax=0;%�����ֵ��ʱ����
pos=0;%��ʱ�Ҷ�λ��
khist=1.5;%����̶�ϵ��
J=rgb2gray(I);%�ҶȻ�

J=myhistf( J,1,500 );
A=fspecial('average',8);
J=filter2(A,J,'same');
%J=medfilt2(J,[5 5]);
[m,n]=size(J);
%% ���о�ֵ��ֵ
threshold=5;
avrm=mean(J,2);
avrn=mean(J,1);
for i=1:m
   for j=1:n
      if  (and((J(i,j)-avrm(i)>threshold), (J(i,j)-avrn(j)>threshold)))
          J(i,j)=1;
      else
          J(i,j)=0;
      end
   end
end
figure(2)
subplot(211)
imshow(J,[])

subplot(212)
BW2 = bwareaopen(J,20,8);
IM2 = imclearborder(BW2,8) ;
imshow(IM2,[])
     
















%% ����ҶƵ���˲�
% figure(2)
% imshow(J)
% figure(1)
% subplot(321)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2+(j-n/2)^2))>10)
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  imshow(abs(log(1+fresult)),[ ]);
%  title('��ͨ�˲���')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(322),imshow(ret);
% title('���')
% % thresh = graythresh(ret);     %�Զ�ȷ����ֵ����ֵ
% % I2 = im2bw(ret,thresh);
% % figure(3)
% % imshow(I2)
% 
% figure(1)
% subplot(323)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2/(n/1.5)+(j-n/2)^2))>10)%�˳������Ƶ
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  hpphoto=mat2gray(abs(log(1+fresult)))*255;
%  
%  imshow(hpphoto,[ ]);
%  title('��ͨ�˲�����������Բ��')
%  FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% subplot(324),imshow(ret);
%  title('���')
% subplot(325)
% fd=fftshift(fft2(J));
% %imshow(abs(log(1+fd)),[ ]);
%  H=zeros(m,n);
%  for i =1:m
%      for j=1:n
%          if((sqrt((i-m/2)^2+(j-n/2)^2/(n/1.5)))>10)%�˳������Ƶ
%              H(i,j)=1;
% %             D=sqrt((m-M)^2+(n-N)^2);
% %             H(m,n)=exp((-D^2)/(2*(D0)^2));
%          end
%      end
%  end
%  %imshow(H)
%  fresult=H.*fd;
%  imshow(abs(log(1+fresult)),[ ]);
%  title('��ͨ�˲�����������Բ��')
%   FS=H.*fresult;
% 
% fr=real(ifft2(ifftshift(FS)));
% ret=im2uint8(mat2gray(fr));
% 
% subplot(326),imshow(ret);
% title('���')
