%% 对特征进行MCFS
load sound_move_val.mat
load sound_tap_val.mat
sound_val=[sound_move_val(2:end,2:end),sound_tap_val(2:end,2:end)];
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\*.jpg');%读取文件夹abc的位置
filenames={file_read.name}';
file_length=length(file_read); 
Y=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        Y=vertcat(Y,A);
    end
end
Y=str2num(Y);
options=[];
options.gnd=Y;
X=cell2mat(sound_val(1:end,:));
X=NormalizeFea(X,1);
X=X(1:1080,:);
[features,FeaNumCandi] = MCFS(X,19,options);           %其中19为所选特征个数，可任意更改

%% 将声音下MCFS后的特征逐个放入SVM进行遍历，得出不同数量特征下不同的分类精度
load sound_move_normalization.mat
load sound_tap_normalization.mat
sound_normalization=[sound_move_normalization,sound_tap_normalization];
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\*.txt');%读取文件夹abc的位置
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
train_group=str2num(B);
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Testing\*.txt');%读取文件夹abc的位置
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
test_group=str2num(B); 
Accuracy=[];
[r,c]=size(sound_normalization);
for k=1:c
[features,FeaNumCandi] = MCFS(X,k,options);
train = sound_normalization(1:1080,cell2mat(features));
test = sound_normalization(1081:end,cell2mat(features));
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10,3,1,1,0.9);
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -b ',num2str(1)];
model=svmtrain(train_group,train,cmd);
disp(cmd);
[predict_label, accuracy, dec_values]=svmpredict(test_group,test,model,'-b 1');
Accuracy=[Accuracy accuracy(1)];
close all;
end
Accuracy_MCFS_sound=Accuracy;