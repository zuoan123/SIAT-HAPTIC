clc; 
clear all;  
format long
%% ��ѵ�����ϵ�ͳ������
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Training\Y\*.txt');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read); 
val_train_time={'��������' 'T_���ֵ' 'T_��Сֵ' 'T_��ֵ' 'T_��ֵ' 'T_����ƽ��ֵ' 'T_������' 'T_����' 'T_��׼��' 'T_������ֵ' 'T_�Ͷ�' 'T_ƫ��' 'T_��������' 'T_��ֵ����' 'T_��������' 'T_ԣ������'};
val_train_frequence={'F_���ֵ' 'F_��Сֵ' 'F_��ֵ' 'F_��ֵ' 'F_����ƽ��ֵ' 'F_������' 'F_����' 'F_��׼��' 'F_������ֵ' 'F_�Ͷ�' 'F_ƫ��' 'F_��������' 'F_��ֵ����' 'F_��������' 'F_ԣ������'};
for i=1:file_length    
    if i<=file_length
    x=textread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Training\Y\',file_read(i).name));   %��ȡ�ļ���λ��
    Fs=10000;
    %% ��ʱ���ϵ�ͳ������
    N = length(x);                                  %��ȡ��������
    t = (0:N-1)/Fs;                                 %��ʾʵ��ʱ��
    p1=max(x);                                      %���ֵ
    p2=min(x);                                      %��Сֵ
    p3=mean(x);                                     %��ֵ
    p4=p1-p2;                                       %��ֵ
    p5=sum(abs(x))/N;                               %����ƽ��ֵ
    p6=sqrt(sum(x.^2)/N);                           %������ֵ 
    p7=var(x);                                      %����
    p8= std(x);                                     %��׼��
    p9=(sum(sqrt(abs(x)))/N).^2;                    %������ֵ
    p10=kurtosis(x);                                %�Ͷ�
    p11=sum(x.^3)/N;                                %ƫ��
    p12= p6/p5;		                            	%��������
    p13= p4/p6;                                     %��ֵ����
    p14= p4/p5;                                     %��������
    xr = mean(sqrt(abs(x)))^2;
    p15= p4/xr;                                     %ԣ������
    time_feature={file_read(i).name p1  p2  p3  p4  p5  p6  p7  p8  p9  p10 p11 p12 p13 p14 p15};  
    val_train_time = vertcat(val_train_time,time_feature);               %vertcat��ƴ�ӣ�horzcat��ƴ�� 
   
    %% ��Ƶ���ϵ�ͳ������
    y = fft(x);%���źŽ��и���Ҷ�任
    f = Fs/N*(0:round(N/2)-1);%��ʾʵ��Ƶ���һ��
    h=abs(y(1:round(N/2)));
    q1=max(h);                                      %���ֵ
    q2=min(h);                                      %��Сֵ
    q3=mean(h);                                     %��ֵ
    q4=p1-p2;                                       %��ֵ
    q5=sum(abs(h))/N;                               %����ƽ��ֵ
    q6=sqrt(sum(h.^2)/N);                           %������ֵ 
    q7=var(h);                                      %����
    q8= std(h);                                     %��׼��
    q9=(sum(sqrt(abs(h)))/N).^2;                    %������ֵ
    q10=kurtosis(h);                                %�Ͷ�
    q11=sum(h.^3)/N;                                %ƫ��
    q12= q6/q5;		                            	%��������
    q13= q4/q6;                                     %��ֵ����
    q14= q4/q5;                                     %��������
    xr = mean(sqrt(abs(h)))^2;
    q15= q4/xr;                                     %ԣ������
    frequence_feature={q1  q2  q3  q4  q5  q6  q7  q8  q9  q10 q11 q12 q13 q14 q15};  
    val_train_frequence = vertcat(val_train_frequence,frequence_feature);                %vertcat��ƴ�ӣ�horzcat��ƴ��
    end
end
%% ���Լ��ϵ�ͳ������
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Testing\Y\*.txt');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read); 
val_test_time={};
val_test_frequence={};
for i=1:file_length    
    if i<=file_length
    x=textread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Testing\Y\',file_read(i).name));   %��ȡ�ļ���λ��
    Fs=10000;
    %% ��ʱ���ϵ�ͳ������
    N = length(x);                                  %��ȡ��������
    t = (0:N-1)/Fs;                                 %��ʾʵ��ʱ��
    x1=max(x);                                      %���ֵ
    x2=min(x);                                      %��Сֵ
    x3=mean(x);                                     %��ֵ
    x4=p1-p2;                                       %��ֵ
    x5=sum(abs(x))/N;                               %����ƽ��ֵ
    x6=sqrt(sum(x.^2)/N);                           %������ֵ 
    x7=var(x);                                      %����
    x8= std(x);                                     %��׼��
    x9=(sum(sqrt(abs(x)))/N).^2;                    %������ֵ
    x10=kurtosis(x);                                %�Ͷ�
    x11=sum(x.^3)/N;                                %ƫ��
    x12= x6/x5;		                            	%��������
    x13= x4/x6;                                     %��ֵ����
    x14= x4/x5;                                     %��������
    xr = mean(sqrt(abs(x)))^2;
    x15= x4/xr;                                     %ԣ������
    time_feature={file_read(i).name x1  x2  x3  x4  x5  x6  x7  x8  x9  x10 x11 x12 x13 x14 x15};  
    val_test_time = vertcat(val_test_time,time_feature);                %vertcat��ƴ�ӣ�horzcat��ƴ��
   
    %% ��Ƶ���ϵ�ͳ������
    y = fft(x);%���źŽ��и���Ҷ�任
    f = Fs/N*(0:round(N/2)-1);%��ʾʵ��Ƶ���һ��
    h=abs(y(1:round(N/2)));
    y1=max(h);                                      %���ֵ
    y2=min(h);                                      %��Сֵ
    y3=mean(h);                                       %��ֵ
    y4=p1-p2;                                       %��ֵ
    y5=sum(abs(h))/N;                               %����ƽ��ֵ
    y6=sqrt(sum(h.^2)/N);                           %������ֵ 
    y7=var(h);                                      %����
    y8= std(h);                                     %��׼��
    y9=(sum(sqrt(abs(h)))/N).^2;                    %������ֵ
    y10=kurtosis(h);                                %�Ͷ�
    y11=sum(h.^3)/N;                                %ƫ��
    y12= y6/y5;		                            	%��������
    y13= y4/y6;                                     %��ֵ����
    y14= y4/y5;                                     %��������
    xr = mean(sqrt(abs(h)))^2;
    y15= y4/xr;                                     %ԣ������
    frequence_feature={y1  y2  y3  y4  y5  y6  y7  y8  y9  y10 y11 y12 y13 y14 y15};  
    val_test_frequence = vertcat(val_test_frequence,frequence_feature);                %vertcat��ƴ�ӣ�horzcat��ƴ�� 
    end
end

val_train=horzcat(val_train_time,val_train_frequence);    
val_test=horzcat(val_test_time,val_test_frequence);                %��ʱ���Ƶ���ͳ����������Ϊһ������
acc_move_val_Y=vertcat(val_train,val_test);                        %��ѵ�����Ͳ��Լ���ͳ����������Ϊһ������
    
%% ���ݹ�һ��
acc_move_normalization_Y=[];
[r,c]=size(acc_move_val_Y);
for i=2:c
    if i<=c
  A=zscore(cell2mat(acc_move_val_Y(2:end,i:i)));                   %ԭ���ݼ�ȥ��ֵ����Ա�׼��
  acc_move_normalization_Y=horzcat(acc_move_normalization_Y,A);
    end
end
