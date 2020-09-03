%% ����������MCFS
load sound_move_val.mat
load sound_tap_val.mat
sound_val=[sound_move_val(2:end,2:end),sound_tap_val(2:end,2:end)];
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\ImageScans\NoFlash\Training\*.jpg');%��ȡ�ļ���abc��λ��
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
[features,FeaNumCandi] = MCFS(X,19,options);           %����19Ϊ��ѡ�������������������

%% ��������MCFS��������������SVM���б������ó���ͬ���������²�ͬ�ķ��ྫ��
load sound_move_normalization.mat
load sound_tap_normalization.mat
sound_normalization=[sound_move_normalization,sound_tap_normalization];
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\*.txt');%��ȡ�ļ���abc��λ��
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
train_group=str2num(B);
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Testing\*.txt');%��ȡ�ļ���abc��λ��
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