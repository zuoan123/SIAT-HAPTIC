
% 加载调用mlknn分类器的数据
%load('KNN_data.mat'); 
svm = struct('type',{},'para',{})
svm(1).type = 'Linear'


% 调用函数
[Weights,Bias,SVs,Weights_sizepre,Bias_sizepre,svm_used,iteration]=RankSVM_train(Ktrain_data.features,Ktrain_data.labels,svm) % 调用训练函数

 [HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Threshold,Pre_Labels]=RankSVM_test(Ktest_data.features,Ktest_data.labels,...
     svm,Weights,Bias,SVs,Weights_sizepre,Bias_sizepre)
 score = 1-HammingLoss
 