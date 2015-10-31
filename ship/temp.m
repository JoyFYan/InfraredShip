clc ;close all;clear;
I=imread('branch.png');%读取图片
tempmax=0;%找最大值临时变量
pos=0;%此时灰度位置
khist=1.5;%均衡程度系数
J=rgb2gray(I);%灰度化
T = myhistf( J,1.5,600 );