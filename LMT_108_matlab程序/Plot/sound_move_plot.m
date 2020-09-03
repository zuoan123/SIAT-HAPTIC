clc; 
clear all;  
format long
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\SoundScans\Movement\Training\*.wav');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read);
for i=1:file_length    
    if i<=file_length
    x=audioread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\SoundScans\Movement\Training\',file_read(i).name)); %��ȡ�ļ���λ��  
    Fs=44100;
    x = x(:,1);
    x = x';
    N = length(x);                              %��ȡ��������
    t = (0:N-1)/Fs;                             %��ʾʵ��ʱ��
    y = fft(x);                                 %���źŽ��и���Ҷ�任
    h = y(:)/max(y);                            %��һ������
    f = Fs/N*(0:round(N/2)-1);                  %��ʾʵ��Ƶ���һ��
    figure(i);
    %figure('Visible','off');                   %ֻ����ͼ��������ʾ
    subplot(2,1,1);
    plot(t,x);                                  %����ʱ����
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
    saveas(gcf,['C:\Users\Administrator\Desktop\TUM���ݼ�\�½��ļ���\plot\SoundScans\Movement\Training\',file_read(i).name,'.pdf'])             %ͼƬ����λ��
    %close(i);                                    %��ʾ���ر�ͼ��
    end
end