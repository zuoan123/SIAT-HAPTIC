
% 加载调用mlknn分类器的数据
load('KNN_data.mat'); 

%设置MLKNN算法所需要的参数
Num=10;   %对象取得最近的实例点的个数
Smooth=1; % 设置平滑参数

% 调用函数
[Prior,PriorN,Cond,CondN]=MLKNN_train(Ktrain_data.features,Ktrain_data.labels,Num,Smooth); % 调用训练函数

[HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels]=MLKNN_test(Ktrain_data.features,Ktrain_data.labels,...
    Ktest_data.features,Ktest_data.labels,Num,Prior,PriorN,Cond,CondN); % 调用测试函数
score = 1-HammingLoss
