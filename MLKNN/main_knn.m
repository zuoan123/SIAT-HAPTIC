
% ���ص���mlknn������������
load('KNN_data.mat'); 

%����MLKNN�㷨����Ҫ�Ĳ���
Num=10;   %����ȡ�������ʵ����ĸ���
Smooth=1; % ����ƽ������

% ���ú���
[Prior,PriorN,Cond,CondN]=MLKNN_train(Ktrain_data.features,Ktrain_data.labels,Num,Smooth); % ����ѵ������

[HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels]=MLKNN_test(Ktrain_data.features,Ktrain_data.labels,...
    Ktest_data.features,Ktest_data.labels,Num,Prior,PriorN,Cond,CondN); % ���ò��Ժ���
score = 1-HammingLoss
