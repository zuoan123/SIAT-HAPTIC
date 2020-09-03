%% ��������ѡ�񷽷���SVM�½��о��߼��ں�
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
figure;
hold on;
plot(test_group,'o');
plot(N,'r*');
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
title('Multi-modal-based categorization','FontSize',10);   
figure;
test_group=test_group';
confusion_matrix1(test_group,N)
xlabel('ʵ�ʱ�ǩ');ylabel('Ԥ���ǩ')
%% ��ӷ���ٷֱȣ��ɺ��ԣ�
[mat,order] = confusionmat(test_group,N);
k=max(order);                                       %kΪ����ĸ���
for i=1:k
    mat(i,10)=mat(i,i)/sum(mat(i,1:9));
end