clc; 
clear all;  
format long
file_read=dir('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\*.txt');%��ȡ�ļ����������ļ�
filenames={file_read.name}';
file_length=length(file_read);
for i=1:file_length    
    if i<=file_length
    x=textread(strcat('C:\Users\Administrator\Desktop\TUM���ݼ�\LMT_108_SurfaceMaterials_Database\AccelScansComponents\Tapping\Training\',file_read(i).name)); %��ȡ�ļ���λ��   
    Fs=10000;
    x = x(:,1);
    x = x';
    N = length(x);                              %��ȡ��������
    t = (0:N-1)/Fs;                             %��ʾʵ��ʱ��
    y = fft(x);                                 %���źŽ��и���Ҷ�任
    h = y(:)/max(y);                            %��һ������
    f = Fs/N*(0:round(N/2)-1);                  %��ʾʵ��Ƶ���һ��
    %figure(i);
    figure('Visible','off');                    %ֻ����ͼ��������ʾ
    subplot(2,1,1);
    plot(t,x);                                  %����ʱ����
    axis([0 max(t) -1 1]);
    xlabel('Time / (s)');ylabel('Amplitude');
    title('�źŵ�ʱ��ͼ');
    grid;
    subplot(2,1,2);
    plot(f,abs(h(1:round(N/2))));
    xlabel('Frequency');ylabel('Amplitude');
    title('�źŵ�Ƶ��ͼ');
    axis ( [1 1000 0 1] );
    grid;
    saveas(gcf,['C:\Users\Administrator\Desktop\TUM���ݼ�\�½��ļ���\plot\AccelScansComponents\Tapping\Training\',file_read(i).name,'.pdf'])             %ͼƬ����λ��
    %close(i);                                  %��ʾ���ر�ͼ��
    end
end