
% ���ص���mlknn������������
%load('KNN_data.mat'); 
svm = struct('type',{},'para',{})
svm(1).type = 'Linear'


% ���ú���
[Weights,Bias,SVs,Weights_sizepre,Bias_sizepre,svm_used,iteration]=RankSVM_train(Ktrain_data.features,Ktrain_data.labels,svm) % ����ѵ������

 [HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Threshold,Pre_Labels]=RankSVM_test(Ktest_data.features,Ktest_data.labels,...
     svm,Weights,Bias,SVs,Weights_sizepre,Bias_sizepre)
 score = 1-HammingLoss
 