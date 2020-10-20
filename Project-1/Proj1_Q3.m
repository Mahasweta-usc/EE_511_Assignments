function Proj1_Q3(N) %No of trials. N = 100
R = binornd(1,0.5,N,1); %Bernoulli as a binomial process with n= 1, p = 0.5 and N trials. R contains sampling results
run_of_ones = cont_count2(R); %to generate lengths of consecutive occurrences of '1's
run_of_ones = run_of_ones(run_of_ones >= 1);
sum(run_of_ones) %Count total number of '1's
disp('No of ones generated') %Display information
count(1,2)
hist(run_of_ones,0:1:10,10) %Histogram of consecutive occurrences
end