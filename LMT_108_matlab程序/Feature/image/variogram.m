function variogram=variogram(im)
im=imread('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\G1EpoxyRasterPlate_Image_1_train1.jpg'); %�������ɫͼ��
im=rgb2gray(im); %ת��Ϊ�Ҷ�ͼ
im=double(im);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����
avg=mean2(im);  %��ͼ���ֵ
[m,n]=size(im);
s=0;
for x=1:m
    for y=1:n
    s=s+(im(x,y)-avg)^2; %��������������ֵ��ƽ���͡�
    end
end
%��ͼ��ķ���
variogram=var(im(:)); %��һ�ַ��������ú���var��á�
% a2=s/(m*n-1); %�ڶ��ַ��������÷��ʽ���
% a3=(std2(im))^2; %�����ַ���������std2��ñ�׼���ƽ����Ϊ���