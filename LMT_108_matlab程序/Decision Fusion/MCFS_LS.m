%% 两种特征选择方法在SVM下进行决策级融合
load probably_LS.mat
load probably_MCFS.mat
m=[];
for a=1:1080
    for b=1:9
        m(a,b)=0.5*probably_MCFS(a,b)+0.5*probably_LS(a,b);
    end
end
for a=1:1080
    [x,y]=max(m(a,:));
    N(a)=y;
end
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Testing\*.txt');%读取文件夹的位置
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
test_group=str2num(B);
figure;
hold on;
plot(test_group,'o');
plot(N,'r*');
legend('实际测试集分类','预测测试集分类');
title('Multi-modal-based categorization','FontSize',10);   
figure;
test_group=test_group';
confusion_matrix1(test_group,N)
xlabel('实际标签');ylabel('预测标签')
%% 添加分类百分比（可忽略）
[mat,order] = confusionmat(test_group,N);
k=max(order);                                       %k为分类的个数
for i=1:k
    mat(i,10)=mat(i,i)/sum(mat(i,1:9));
end