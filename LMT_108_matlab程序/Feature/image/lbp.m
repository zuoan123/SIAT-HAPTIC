%参考 https://blog.csdn.net/gl486546/article/details/80358713
%     https://blog.csdn.net/kuaitoukid/article/details/8643253
function lbpI = lbp(im)
im=imread('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\G1EpoxyRasterPlate_Image_1_train1.jpg');
I = imresize(im,[256 256]);
[m,n,h] = size(I);
if h==3
    I = rgb2gray(I);
end
lbpI = uint8(zeros([m n]));
for i = 2:m-1
    for j = 2:n-1
        neighbor = [I(i-1,j-1) I(i-1,j) I(i-1,j+1) I(i,j+1) I(i+1,j+1) I(i+1,j) I(i+1,j-1) I(i,j-1)] > I(i,j);
        pixel = 0;
        for k = 1:8
            pixel = pixel + neighbor(1,k) * bitshift(1,8-k);
        end
        lbpI(i,j) = uint8(pixel);
    end
end

% clear all;
% close all;
% clc;
% im=imread('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\G1EpoxyRasterPlate_Image_1_train1.jpg');
% 
% [m n]=size(im);
% imgn=zeros(m,n);
% for i=2:m-1
%    for j=2:n-2 
%         
%        pow=0;
%         for p=i-1:i+1
%             for q =j-1:j+1
%                 if im(p,q) > im(i,j)
%                     if p~=i || q~=j         %有的文章这里是3*3的顺时针编码，我就按处理顺序编码了。
%                                             %反正都是特征描述啥的，只要按相同规则就行了。
%                       imgn(i,j)=imgn(i,j)+2^pow;
%                       pow=pow+1;
%                     end
%                 end
%             end
%         end
%             
%    end
% end
% figure;
% imshow(imgn,[]);
% hist=cell(1,4);     %划分四个区域求直方图，10*10的太多了，这里搞简单点
% hist{1}=imhist(im(1:floor(m/2),1:floor(n/2)));
% hist{2}=imhist(im(1:floor(m/2),floor(n/2)+1:n));
% hist{3}=imhist(im(floor(m/2)+1:m,1:floor(n/2)));
% hist{4}=imhist(im(floor(m/2)+1:m,floor(n/2)+1:n));
% for i=1:4
%    figure;
%    plot(hist{i});
% end