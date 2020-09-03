clc; 
clear all;  
format long
file_read=dir('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\SoundScans\Movement\Training\*.wav');%读取文件夹下所有文件
filenames={file_read.name}';
file_length=length(file_read);
for i=1:file_length    
    if i<=file_length
    x=audioread(strcat('C:\Users\Administrator\Desktop\TUM数据集\LMT_108_SurfaceMaterials_Database\SoundScans\Movement\Training\',file_read(i).name)); %读取文件夹位置  
    Fs=44100;
    x = x(:,1);
    x = x';
    N = length(x);                              %求取抽样点数
    t = (0:N-1)/Fs;                             %显示实际时间
    y = fft(x);                                 %对信号进行傅里叶变换
    h = y(:)/max(y);                            %归一化处理
    f = Fs/N*(0:round(N/2)-1);                  %显示实际频点的一半
    figure(i);
    %figure('Visible','off');                   %只保存图窗而不显示
    subplot(2,1,1);
    plot(t,x);                                  %绘制时域波形
    axis([0 max(t) -1 1]);
    title('Time domain diagram of the signal');
    xlabel('Time (s)','Fontname', 'Times New Roman','FontSize',30);
    ylabel('Voltage (V)','Fontname', 'Times New Roman','FontSize',30);
    set(get(gca,'TITLE'),'FontSize',10);
    set(gca,'fontsize',10);
    grid;
    subplot(2,1,2);
    plot(f,abs(h(1:round(N/2))));
    xlabel('Frequency (Hz)','Fontname', 'Times New Roman','FontSize',30);
    ylabel('Amplitude (dB)','Fontname', 'Times New Roman','FontSize',30);
    title('Frequency domain diagram of the signal');
    axis ( [1 10000 0 1] );
    set(get(gca,'TITLE'),'FontSize',20);
    set(gca,'fontsize',10);
    grid; 
    saveas(gcf,['C:\Users\Administrator\Desktop\TUM数据集\新建文件夹\plot\SoundScans\Movement\Training\',file_read(i).name,'.pdf'])             %图片保存位置
    %close(i);                                    %显示并关闭图窗
    end
end