function variogram=variogram(im)
im=imread('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\G1EpoxyRasterPlate_Image_1_train1.jpg'); %载入真彩色图像
im=rgb2gray(im); %转换为灰度图
im=double(im);  %将uint8型转换为double型，否则不能计算统计量
avg=mean2(im);  %求图像均值
[m,n]=size(im);
s=0;
for x=1:m
    for y=1:n
    s=s+(im(x,y)-avg)^2; %求得所有像素与均值的平方和。
    end
end
%求图像的方差
variogram=var(im(:)); %第一种方法：利用函数var求得。
% a2=s/(m*n-1); %第二种方法：利用方差公式求得
% a3=(std2(im))^2; %第三种方法：利用std2求得标准差，再平方即为方差。