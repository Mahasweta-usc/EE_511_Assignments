function [] = MonteC(simulations) %Simulations contains the number of MC samplings
estimated = []; %contains estimated integrals for various n
for i =1:length(simulations)
    Q1 = zeros(simulations(i),3); %contains the values of f(u) over different u
    u = rand(simulations(i),1); %sample u and v
    v = rand(simulations(i),1);
    fun1 = @(x) 4.*exp((4.*u-2) + ((4.*u-2).^2)); %Define the integrals over 0 to 1
    fun2 = @(x) 2.*exp(-((1./u)-1).^2).*((1./u).^2);
    fun3 = @(x,y) exp(-(x+y).^2);
    Q1(:,1) = fun1(u); %evaluate the functions over the r.v.s generated
    Q1(:,2) = fun2(u);
    Q1(:,3) = fun3(u,v);
    results = mean(Q1,1); %calculate the mean of the function values
    estimated = [estimated;results] %store the results for each n
end
fun_1 = @(x) exp(x.^2 + x); %define the original functions
ground = integral(fun_1,-2,2); %calculate integrals using MATLAB inbuilt
fun_2 = @(x) exp(-(x.^2));
ground(2,1) = integral(fun_2,-Inf,Inf);
fun_3 = @(x,y) exp(-power(x+y,2));
ground(3,1) = integral2(fun_3,0,1,0,1); 
ground %display the ground truth
hold on
plot(simulations,abs(ground(1,:) - estimated(:,1)')) %Plot the variation of absolute error 
title(strcat('Absolute error vs N')); %for function 1 with n
xlabel('N');
ylabel('Error');
end