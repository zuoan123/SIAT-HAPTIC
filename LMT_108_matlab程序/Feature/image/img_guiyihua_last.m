clc; 
clear all; 
format long
%% 训练集上的特征
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\*.jpg');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read); 
val_train_img={'表面名称' 'energy' 'entropy' 'correlation' 'homogeneity' 'contrast' 'sre1' 'lre1' 'gln1' 'hgo'  'Fcoarseness' 'Fcontrast'};
for x=1:file_length    
    if x<=file_length
    im=imread(strcat('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\',file_read(x).name));
    [energy,entropy,correlation,homogeneity,contrast]=glcm(im);
    [sre1,lre1,gln1]= glrlm(im);
    hgo=mean(HOG(im));
    %variogram=variogram(im);
    [Fcoarseness,Fcontrast,Fdirection] = Tamura(im);
    img_train_feature={file_read(x).name energy entropy correlation homogeneity contrast sre1 lre1 gln1 hgo  Fcoarseness Fcontrast };  
    val_train_img = vertcat(val_train_img,img_train_feature);   
    end
end
%% 测试集上的特征
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Testing\*.jpg');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read); 
val_test_img={};
for x=1:file_length    
    if x<=file_length
    im=imread(strcat('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Testing\',file_read(x).name));
    [energy,entropy,correlation,homogeneity,contrast]=glcm(im);
    [sre1,lre1,gln1]= glrlm(im);
    hgo=mean(HOG(im));
    %variogram=variogram(im);
    [Fcoarseness,Fcontrast,Fdirection] = Tamura(im);
    img_test_feature={file_read(x).name energy entropy correlation homogeneity contrast sre1 lre1 gln1 hgo  Fcoarseness Fcontrast };   
    val_test_img = vertcat(val_test_img,img_test_feature);   
    end
end
img_val=vertcat(val_train_img,val_test_img);                        %将训练集和测试集的统计特征整合为一个数组

%% 数据归一化
img_normalization=[];
[r,c]=size(img_val);
for i=2:c
    if i<=c
  W=zscore(cell2mat(img_val(2:end,i:i)));                           %原数据减去均值后除以标准差
  img_normalization=horzcat(img_normalization,W);
    end
end