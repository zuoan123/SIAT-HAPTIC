load acc_move_normalization.mat
load acc_tap_normalization.mat
acc_normalization=[acc_move_normalization,acc_tap_normalization];
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\*.txt');%��ȡ�ļ��е�λ��
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
train_group=str2num(B);
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Testing\*.txt');%��ȡ�ļ��е�λ��
file_length=length(file_read); 
B=[ ];
for i=1:file_length    
    if i<=file_length
        A=file_read(i).name(2:2);
        B=vertcat(B,A);
    end
end
test_group=str2num(B);  
train = acc_normalization(1:1080,[185;82;175;115;165;46;130;76;166;16;22;52;145;25;142;136;116;187;55]);
test = acc_normalization(1081:end,[185;82;175;115;165;46;130;76;166;16;22;52;145;25;142;136;116;187;55]);
%[bestCVaccuracy,bestc,bestg]= SVMcgForClass(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
%bestCVaccuracy:����CV�����µ���ѷ���׼ȷ��;bestc:��ѵĲ���c;bestg:��ѵĲ���g��
%v:����Cross Validation�����еĲ���������ѵ��������v-fold Cross Validation��Ĭ��Ϊ3����Ĭ�Ͻ���3�۽�����֤����
%cstep,gstep:���в���Ѱ����c��g�Ĳ�����С��Ĭ��ȡֵΪcstep=1,gstep=1��
%accstep:������ѡ����ͼ��׼ȷ����ɢ����ʾ�Ĳ��������С��[0,100]֮���һ��������Ĭ��Ϊ4.5��
%����ѡ��c&g �ı仯��Χ�� 2^(-10),2^(-9),...,2^(10)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10,3,1,1,0.9);
%��ϸѡ��c �ı仯��Χ�� 2^(-2),2^(-1.5),...,2^(4), g �ı仯��Χ�� 2^(-4),2^(-3.5),...,2^(4)
%[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-2,4,-4,4,3,0.5,0.5,0.9);                                                                                                                                                                                                                                                                                                                                                               
%ѵ��ģ��
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -b ',num2str(1)];
model=svmtrain(train_group,train,cmd);
disp(cmd);
%predict_label���洢�ŷ������������Ӧ��������
%accuracy��һ��3 * 1�����飬����Ϊ���������ȷ�ʡ��ع�ľ��������ع��ƽ�����ϵ��
%dec_values����һ����ʾ���ʵ����飬ÿһ�б�ʾ��������ֱ�����ÿһ�����ĸ���
%���Է���
[predict_label, accuracy, probably_MCFS_acc]=svmpredict(test_group,test,model,'-b 1');
%��ӡ���Է�����
figure;
hold on;
plot(test_group,'o');
plot(predict_label,'r*');
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',10);   
figure;
predict_label=predict_label';
test_group=test_group';
confusion_matrix1(test_group,predict_label);
xlabel('ʵ�ʱ�ǩ');ylabel('Ԥ���ǩ');

%% ��ӷ���ٷֱȣ��ɺ��ԣ�
[mat,order] = confusionmat(test_group,predict_label);
k=max(order);                                               %kΪ����ĸ���
for i=1:k
    mat(i,10)=mat(i,i)/sum(mat(i,1:9));
end
