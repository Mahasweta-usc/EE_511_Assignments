 N = [50,200,1000,10000];
    for i = 1:4
        [X,Y,values(i)] = SA(N(i));
    end
    figure(3)
bar(values);
xlabel('Number of runs')
ylabel('Optimal minima value obtained');
title('logarithmic cooling');