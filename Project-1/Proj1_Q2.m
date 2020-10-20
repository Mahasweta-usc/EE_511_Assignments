function Proj1_Q2(N) %N = 200, or number of trials
R = binornd(1,0.8,N,1); %Bernoulli as a binomial process with n = 1, p = 0.8. R contains sampling results
run_of_ones = cont_count(R); %Evaluate longest run of ones. Refer to Q1.
count = hist(R, [0,1],2); %count number of '1's and '0's
ones_t = count(1,2); %no of ones in trial
disp('Number of trials: ') %Display results
N
disp('total number of ones obtained in this experiment: ')
ones_t
disp('Longest run of ones: ')
run_of_ones
hist(R, [0,1],2) %Generate outcome histogram
end