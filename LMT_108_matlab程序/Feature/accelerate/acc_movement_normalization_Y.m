clc; 
clear all;  
format long
%% 求训练集上的统计特征
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Training\Y\*.txt');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read); 
val_train_time={'表面名称' 'T_最大值' 'T_最小值' 'T_均值' 'T_峰值' 'T_绝对平均值' 'T_均方根' 'T_方差' 'T_标准差' 'T_方根幅值' 'T_峭度' 'T_偏度' 'T_波形因子' 'T_峰值因子' 'T_脉冲因子' 'T_裕度因子'};
val_train_frequence={'F_最大值' 'F_最小值' 'F_均值' 'F_峰值' 'F_绝对平均值' 'F_均方根' 'F_方差' 'F_标准差' 'F_方根幅值' 'F_峭度' 'F_偏度' 'F_波形因子' 'F_峰值因子' 'F_脉冲因子' 'F_裕度因子'};
for i=1:file_length    
    if i<=file_length
    x=textread(strcat('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Training\Y\',file_read(i).name));   %读取文件夹位置
    Fs=10000;
    %% 求时域上的统计特征
    N = length(x);                                  %求取抽样点数
    t = (0:N-1)/Fs;                                 %显示实际时间
    p1=max(x);                                      %最大值
    p2=min(x);                                      %最小值
    p3=mean(x);                                     %均值
    p4=p1-p2;                                       %峰值
    p5=sum(abs(x))/N;                               %绝对平均值
    p6=sqrt(sum(x.^2)/N);                           %均方根值 
    p7=var(x);                                      %方差
    p8= std(x);                                     %标准差
    p9=(sum(sqrt(abs(x)))/N).^2;                    %方根幅值
    p10=kurtosis(x);                                %峭度
    p11=sum(x.^3)/N;                                %偏度
    p12= p6/p5;		                            	%波形因子
    p13= p4/p6;                                     %峰值因子
    p14= p4/p5;                                     %脉冲因子
    xr = mean(sqrt(abs(x)))^2;
    p15= p4/xr;                                     %裕度因子
    time_feature={file_read(i).name p1  p2  p3  p4  p5  p6  p7  p8  p9  p10 p11 p12 p13 p14 p15};  
    val_train_time = vertcat(val_train_time,time_feature);               %vertcat行拼接，horzcat列拼接 
   
    %% 求频域上的统计特征
    y = fft(x);%对信号进行傅里叶变换
    f = Fs/N*(0:round(N/2)-1);%显示实际频点的一半
    h=abs(y(1:round(N/2)));
    q1=max(h);                                      %最大值
    q2=min(h);                                      %最小值
    q3=mean(h);                                     %均值
    q4=p1-p2;                                       %峰值
    q5=sum(abs(h))/N;                               %绝对平均值
    q6=sqrt(sum(h.^2)/N);                           %均方根值 
    q7=var(h);                                      %方差
    q8= std(h);                                     %标准差
    q9=(sum(sqrt(abs(h)))/N).^2;                    %方根幅值
    q10=kurtosis(h);                                %峭度
    q11=sum(h.^3)/N;                                %偏度
    q12= q6/q5;		                            	%波形因子
    q13= q4/q6;                                     %峰值因子
    q14= q4/q5;                                     %脉冲因子
    xr = mean(sqrt(abs(h)))^2;
    q15= q4/xr;                                     %裕度因子
    frequence_feature={q1  q2  q3  q4  q5  q6  q7  q8  q9  q10 q11 q12 q13 q14 q15};  
    val_train_frequence = vertcat(val_train_frequence,frequence_feature);                %vertcat行拼接，horzcat列拼接
    end
end
%% 测试集上的统计特征
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Testing\Y\*.txt');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read); 
val_test_time={};
val_test_frequence={};
for i=1:file_length    
    if i<=file_length
    x=textread(strcat('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Movement\Testing\Y\',file_read(i).name));   %读取文件夹位置
    Fs=10000;
    %% 求时域上的统计特征
    N = length(x);                                  %求取抽样点数
    t = (0:N-1)/Fs;                                 %显示实际时间
    x1=max(x);                                      %最大值
    x2=min(x);                                      %最小值
    x3=mean(x);                                     %均值
    x4=p1-p2;                                       %峰值
    x5=sum(abs(x))/N;                               %绝对平均值
    x6=sqrt(sum(x.^2)/N);                           %均方根值 
    x7=var(x);                                      %方差
    x8= std(x);                                     %标准差
    x9=(sum(sqrt(abs(x)))/N).^2;                    %方根幅值
    x10=kurtosis(x);                                %峭度
    x11=sum(x.^3)/N;                                %偏度
    x12= x6/x5;		                            	%波形因子
    x13= x4/x6;                                     %峰值因子
    x14= x4/x5;                                     %脉冲因子
    xr = mean(sqrt(abs(x)))^2;
    x15= x4/xr;                                     %裕度因子
    time_feature={file_read(i).name x1  x2  x3  x4  x5  x6  x7  x8  x9  x10 x11 x12 x13 x14 x15};  
    val_test_time = vertcat(val_test_time,time_feature);                %vertcat行拼接，horzcat列拼接
   
    %% 求频域上的统计特征
    y = fft(x);%对信号进行傅里叶变换
    f = Fs/N*(0:round(N/2)-1);%显示实际频点的一半
    h=abs(y(1:round(N/2)));
    y1=max(h);                                      %最大值
    y2=min(h);                                      %最小值
    y3=mean(h);                                       %均值
    y4=p1-p2;                                       %峰值
    y5=sum(abs(h))/N;                               %绝对平均值
    y6=sqrt(sum(h.^2)/N);                           %均方根值 
    y7=var(h);                                      %方差
    y8= std(h);                                     %标准差
    y9=(sum(sqrt(abs(h)))/N).^2;                    %方根幅值
    y10=kurtosis(h);                                %峭度
    y11=sum(h.^3)/N;                                %偏度
    y12= y6/y5;		                            	%波形因子
    y13= y4/y6;                                     %峰值因子
    y14= y4/y5;                                     %脉冲因子
    xr = mean(sqrt(abs(h)))^2;
    y15= y4/xr;                                     %裕度因子
    frequence_feature={y1  y2  y3  y4  y5  y6  y7  y8  y9  y10 y11 y12 y13 y14 y15};  
    val_test_frequence = vertcat(val_test_frequence,frequence_feature);                %vertcat行拼接，horzcat列拼接 
    end
end

val_train=horzcat(val_train_time,val_train_frequence);    
val_test=horzcat(val_test_time,val_test_frequence);                %将时域和频域的统计特征整合为一个数组
acc_move_val_Y=vertcat(val_train,val_test);                        %将训练集和测试集的统计特征整合为一个数组
    
%% 数据归一化
acc_move_normalization_Y=[];
[r,c]=size(acc_move_val_Y);
for i=2:c
    if i<=c
  A=zscore(cell2mat(acc_move_val_Y(2:end,i:i)));                   %原数据减去均值后除以标准差
  acc_move_normalization_Y=horzcat(acc_move_normalization_Y,A);
    end
end
