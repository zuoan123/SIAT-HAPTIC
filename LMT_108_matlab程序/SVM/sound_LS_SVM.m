load sound_move_normalization.mat
load sound_tap_normalization.mat
sound_normalization=[sound_move_normalization,sound_tap_normalization];
%定义训练集标签
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
%定义测试集标签
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
train = sound_normalization(1:1080,:);
test = sound_normalization(1081:end,:);
%[bestCVaccuracy,bestc,bestg]= SVMcgForClass(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
%bestCVaccuracy:最终CV意义下的最佳分类准确率;bestc:最佳的参数c;bestg:最佳的参数g。
%v:进行Cross Validation过程中的参数，即对训练集进行v-fold Cross Validation，默认为3，即默认进行3折交叉验证过程
%cstep,gstep:进行参数寻优是c和g的步进大小，默认取值为cstep=1,gstep=1。
%accstep:最后参数选择结果图中准确率离散化显示的步进间隔大小（[0,100]之间的一个数），默认为4.5。
%粗略选择：c&g 的变化范围是 2^(-10),2^(-9),...,2^(10)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10,3,1,1,0.9);
%精细选择：c 的变化范围是 2^(-2),2^(-1.5),...,2^(4), g 的变化范围是 2^(-4),2^(-3.5),...,2^(4)
%[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-2,4,-4,4,3,0.5,0.5,0.9);                                                                                                                                                                                                                                                                                                                                                               
%训练模型
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -b ',num2str(1)];
model=svmtrain(train_group,train,cmd);
disp(cmd);
%predict_label：存储着分类后样本所对应的类属性
%accuracy：一个3 * 1的数组，依次为：分类的正确率、回归的均方根误差、回归的平方相关系数
%dec_values：是一个表示概率的数组，每一行表示这个样本分别属于每一个类别的概率
%测试分类
[predict_label, accuracy, probably_LS_sound]=svmpredict(test_group,test,model,'-b 1');
%打印测试分类结果
figure;
hold on;
plot(test_group,'o');
plot(predict_label,'r*');
legend('实际测试集分类','预测测试集分类');
title('Multimodal categorization','FontSize',10);   
figure;
predict_label=predict_label';
test_group=test_group';
confusion_matrix1(test_group,predict_label)
xlabel('实际标签');ylabel('预测标签')
%% 添加分类百分比（可忽略）
[mat,order] = confusionmat(test_group,predict_label);
k=max(order);                                                    %k为分类的个数
for i=1:k
    mat(i,10)=mat(i,i)/sum(mat(i,1:9));
end
