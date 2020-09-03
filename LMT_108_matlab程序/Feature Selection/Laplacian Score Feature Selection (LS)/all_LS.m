%% 求拉普拉斯分值
load acc_move_val.mat
load acc_tap_val.mat
load sound_move_val.mat
load sound_tap_val.mat
load img_val.mat
all_val=[acc_move_val(2:end,2:end),acc_tap_val(2:end,2:end),sound_move_val(2:end,2:end),sound_tap_val(2:end,2:end),img_val(2:end,2:end)];
X=cell2mat(all_val(1:end,:));
X=NormalizeFea(X,1);
X=X(1:1080,:);
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\*.jpg');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read); 
% 分为9类
groub=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        groub=vertcat(groub,A);
    end
end
nClass = length(unique(groub));
label = litekmeans(X,nClass,'Replicates',10);
MIhat = MutualInfo(groub,label);
disp(['kmeans use all the features. MIhat: ',num2str(MIhat)]);
W= constructW(X);
Y = LaplacianScore(X, W);
[dump,idx] = sort(-Y);
%% 将LS后的特征逐个放入SVM进行遍历，得出不同数量特征下不同的分类精度
load acc_move_normalization.mat
load acc_tap_normalization.mat
load sound_move_normalization.mat
load sound_tap_normalization.mat
load img_normalization.mat
all_normalization=[acc_move_normalization,acc_tap_normalization,sound_move_normalization,sound_tap_normalization,img_normalization];
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\*.txt');%读取文件夹下所有文件
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
train_group=str2num(B);
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Testing\*.txt');%读取文件夹下所有文件
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
for k=1:length(idx)
train = all_normalization(1:1080,idx(1:k,:));
test = all_normalization(1081:end,idx(1:k,:));
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10,3,1,1,0.9);
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -b ',num2str(1)];
model=svmtrain(train_group,train,cmd);
disp(cmd);
[predict_label, accuracy, dec_values]=svmpredict(test_group,test,model,'-b 1');
Accuracy=[Accuracy accuracy(1)];
close all;
end
Accuracy_LS=Accuracy';