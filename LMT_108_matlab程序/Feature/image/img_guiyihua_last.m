clc; 
clear all; 
format long
%% ѵ�����ϵ�����
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\*.jpg');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read); 
val_train_img={'��������' 'energy' 'entropy' 'correlation' 'homogeneity' 'contrast' 'sre1' 'lre1' 'gln1' 'hgo'  'Fcoarseness' 'Fcontrast'};
for x=1:file_length    
    if x<=file_length
    im=imread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\',file_read(x).name));
    [energy,entropy,correlation,homogeneity,contrast]=glcm(im);
    [sre1,lre1,gln1]= glrlm(im);
    hgo=mean(HOG(im));
    %variogram=variogram(im);
    [Fcoarseness,Fcontrast,Fdirection] = Tamura(im);
    img_train_feature={file_read(x).name energy entropy correlation homogeneity contrast sre1 lre1 gln1 hgo  Fcoarseness Fcontrast };  
    val_train_img = vertcat(val_train_img,img_train_feature);   
    end
end
%% ���Լ��ϵ�����
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Testing\*.jpg');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read); 
val_test_img={};
for x=1:file_length    
    if x<=file_length
    im=imread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Testing\',file_read(x).name));
    [energy,entropy,correlation,homogeneity,contrast]=glcm(im);
    [sre1,lre1,gln1]= glrlm(im);
    hgo=mean(HOG(im));
    %variogram=variogram(im);
    [Fcoarseness,Fcontrast,Fdirection] = Tamura(im);
    img_test_feature={file_read(x).name energy entropy correlation homogeneity contrast sre1 lre1 gln1 hgo  Fcoarseness Fcontrast };   
    val_test_img = vertcat(val_test_img,img_test_feature);   
    end
end
img_val=vertcat(val_train_img,val_test_img);                        %��ѵ�����Ͳ��Լ���ͳ����������Ϊһ������

%% ���ݹ�һ��
img_normalization=[];
[r,c]=size(img_val);
for i=2:c
    if i<=c
  W=zscore(cell2mat(img_val(2:end,i:i)));                           %ԭ���ݼ�ȥ��ֵ����Ա�׼��
  img_normalization=horzcat(img_normalization,W);
    end
end