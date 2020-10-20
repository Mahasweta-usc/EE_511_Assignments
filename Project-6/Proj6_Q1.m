time_boxm = zeros(10,1); %Stores runtime for Box Muller for 10 iterations
time_marsag = zeros(10,1); %Stores runtime for Polar Marsaglia
mean_boxm = zeros(10,1); %Stores means for Box Muller
var_boxm = zeros(10,1); %Stores sample variances for Box Muller
mean_marsag = zeros(10,1); %Stores means for Polar Marsaglia
var_marsag = zeros(10,1);  %Stores sample variances for Polar Marsaglia
covariances = zeros(10,1); %Stores Covariances between the two R.V.s generated in Polar Marsaglia

for j = 1:10
    X = zeros(1000000,1);  %Stores N(1,4)
    Y = zeros(1000000,1);  %Stores N(2,9)
    A_boxm = zeros(1000000,1);  %Stores X + Y for Box Muller
    tic %starts tracking time lapse
    for i = 1:1000000 %generating each sample
        U1 = rand(1); %generating U1 and U2
        U2 = rand(1);
        N1 = sqrt(-2*log(U1))*cos(2*pi*U2); %Generating the two normal r.v.s
        N2 = sqrt(-2*log(U2))*sin(2*pi*U1);
        X(i) = 1 + 2*N1; %Scaling and shifting the R.V.s
        Y(i) = 2 + 3*N2;
        A_boxm(i) = X(i) + Y(i); %Combining X and Y
    end
    mean_boxm(j) = mean(A_boxm);
    var_boxm(j) = var(A_boxm);
    time_boxm(j) = toc; %storing time lapse
    
    X = zeros(1000000,1); %stores the samples for X and Y generated by Polar Marsaglia
    Y = zeros(1000000,1);
    A_marsag = zeros(1000000,1); %Stores the samples for A by Polar Marsaglia
    U =  unifrnd(-1,1);
    V = unifrnd(-1,1);
    s = U^2 + V^2;
    tic
    for i = 1:1000000
        flag = 1;
        
        while(flag)
            U = unifrnd(-1,1); %generating uniform random variables between -1 and 1
            V = unifrnd(-1,1);
            s = U^2 + V^2;  %evaluate s
            if(s < 1)   %generate (u,v) till s<1
                flag = 0;
            end
        end
        R1 = U*sqrt((-2*log(s))/s); %generate the pair of normal variables
        R2 = V*sqrt((-2*log(s))/s);
        X(i) = 1 + 2*R1; %scale and shift accordingly
        Y(i) = 2 + 3*R2;
        A_marsag(i) = X(i) + Y(i); %store A
    end
    temp = cov((X-1)/2,(Y-2)/3);  %calculate covariance between R1 and R2
    covariances(j) = temp(1,2); %store the result
    mean_marsag(j) = mean(A_marsag);  %store mean and variance for samples
    var_marsag(j) = var(A_marsag);
    time_marsag(j) = toc; %store time lapse for the iteration
end
%plot results for all iterations
figure(1)
histfit(A_boxm(1:1000),21,'normal')  %Plot histogram for first 1000 samples Box Muller
xlabel('Sample Values')
ylabel('Frequency of occurence')
title('Box Muller for 1000 samples')
figure(2)
histfit(A_marsag,21,'normal') %Plot Histogram for Polar Marsaglia with normal fit
xlabel('Sample Values')
ylabel('Frequency of occurence')
title('Polar Marsaglia for 1000000 samples')
figure(3)
plot(1:10,time_boxm) %Plot runtimes
hold on
plot(1:10,time_marsag)
xlabel('Iteration Number')
ylabel('Time Taken')
title('Comparision of run times')
legend('show','Box Muller','Polar Marsaglia')
figure(4)
histfit(A_boxm(1:1000000),21,'normal')  %Plot all samples from Box Muller with normal fit
xlabel('Sample Values')
ylabel('Frequency of occurence')
title('Box Muller for 1000000 values') 
figure(5)
plot(1:10, mean_boxm)      %Plot means for Box Muller 
xlabel('Iteration Number')
ylabel('Mean obtained')
title('Means obtained for Box Muller')
figure(6)
plot(1:10, mean_marsag)  %Plot means for Polar Marsaglia
xlabel('Iteration Number')
ylabel('Mean obtained')
title('Means obtained for Polar Marsaglia')
figure(7)
plot(1: 10, var_boxm)  %Plot variances for Box Muller
xlabel('Iteration Number')
ylabel('Variance obtained')
title('Variance obtained for Box Muller')
figure(8)
plot(1:10, var_marsag) %Plot variances for Polar Marsaglia
xlabel('Iteration Number')
ylabel('Variance obtained')
title('Variance obtained for Polar Marsaglia')
figure(9)
plot(1:10, covariances) %Plot variances between R1 and R2
xlabel('Iteration Number')
ylabel('Covariances')
title('Covariance of R1/R2 for Polar Marsaglia')










