clc ;close all;clear;
I=imread('branch.png');%��ȡͼƬ
tempmax=0;%�����ֵ��ʱ����
pos=0;%��ʱ�Ҷ�λ��
khist=1.5;%����̶�ϵ��
J=rgb2gray(I);%�ҶȻ�
T = myhistf( J,1.5,600 );