for i = 1:70
    for k = 1:24
        if(Ktest_data.labels(k,i)==0)
            Ktest_data.labels(k,i)= Ktest_data.labels(k,i)-1;
        end
    end
end
            