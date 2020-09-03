function hwfs(data,label,cvind)
%If the function is required to run on any other dataset we can just load
%the dataset into the environment and discard the below command i.e load 'HW1Part2Dataset.mat';
%load 'HW1Part2Dataset.mat';
%label=label';
S = [];
W = [];
P=[];
Totalbestval = 0;
loop=1;
while loop>0
    bestval=0;
    bestidx=0;
    correct_val=0;
    
    
    for i1=1:size(data,2)
        if ~ismember(i1,S)
            cp=classperf(label);
                for k = 1:10
                 
                    test = (cvind == k); train = ~test;
                    %data2=[S bestidx];
                    %data2=data(:,i1);
                    if isempty(S)
                        data2=data(:,i1);
                        %obj=fitcdiscr(data2,label);
                        %cvmodel = crossval(obj);
                        %L = kfoldLoss(cvmodel,'lossfun','classiferror')

                        class = classify(data2(test,:),data2(train,:),label(train,:));
                        classperf(cp,class,test);
                    else
                    data2=[data(:,S) data(:,i1)]; 
                    class = classify(data2(test,:),data2(train,:),label(train,:));
                    classperf(cp,class,test);
                    end
                end
                Correct_rate=cp.CorrectRate;
                Error_rate=cp.ErrorRate;
                if Correct_rate>correct_val
                %if Error_rate-bestval>0.01
                %if Error_rate>bestval
                    %totalbestval = Error_rate;
                    bestval = Error_rate;
                    correct_val=Correct_rate;
                    bestidx = i1;
                end
      
                
        end
    end
    %S = [S bestidx];
    %W = [W bestval];
    if correct_val - Totalbestval<=0.01
    %if bestval-Totalbestval<0.01
    %if (((Error_rate-bestval)/Error_rate)*100)<=0.01
        %loop=loop-1;
        break;
    else
        S = [S bestidx];
        W = [W bestval];
        P= [P correct_val];
        loop=loop+1;
        Totalbestval=correct_val;
        %Totalbestval = bestval;
        %S = [S bestidx];
        %W = [W bestval];
        %bestidx = i1;
    end
end

Selected_Features=S
Performance_Features=P(length(P))
%Selected_Features = S
%Performance_Sel_Features=P(length(P))
end

                    