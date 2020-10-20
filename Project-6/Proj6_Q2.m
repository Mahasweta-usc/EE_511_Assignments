f = @(x) gampdf(x,5.5,1)/exppdf(x,5.5);
max_x = fminbnd(@(x) -f(x),0,100); % Find max(f(x)/g(x))
c = gampdf(max_x,5.5,1)/exppdf(max_x,5.5);

accept = 0; %Initialize accept, reject and c
reject = 0;

valid_outcomes = zeros(10000,1); %vector containing valid outcomes for all 1000 simulations
for k = 1:10000 %start of experiment
    flag = 1;
    while(flag) %if draw rejected
        
        y = exprnd(5.5,1,1); %draw a sample from auxiliary distribution
        u = rand(); %draw a random variable
        if(u >= (gampdf(y,5.5,1)/(c*exppdf(y,5.5)))) %If condition not satisfied
            reject = reject + 1; %increment reject
        else
            flag = 0;
        end
    end
    valid_outcomes(k) = y; %store the valid outcome
    accept =accept + 1; %update increment
end
efficiency = accept/(accept + reject); %calculate efficiency

disp('Accept-Reject efficiency'); %Display result
efficiency

%Display Histogram of outcomes
histfit(valid_outcomes,50,'gamma')
xlabel('Values')
ylabel('Frequency')
title('Histogram of 10000 Samples')