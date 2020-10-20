function Proj1_Q1(N, repetitions) % N = number of trials per experiment
count_ones = zeros(repetitions,1); %repetitions: number of times experiment to be repeated
for i = 1:repetitions
R = binornd(1,0.5,50,1); %Bernoulli simulation as a binomial process with n = 1, p = 0.5
run_of_ones = cont_count(R); %To evaluate the longest run of '1's
tally = hist(R, [0,1],2); %tally contained number of ones and zeros obtained
count_ones(i,1) = tally(1,2); %count_ones = number of ones
disp('Number of trials: ') %Display information
N
disp('total number of ones obtained in this experiment: ')
count_ones(i,1)
disp('Longest run of ones: ')
run_of_ones
end
hist(count_ones,[15:1:35],21) %Generate histogram for the number of heads each experiment
std(count_ones)
figure(2)
hist(R,[0 1],2) %Generate a single experiment histogram
sample_mean = mean(count_ones) %Sample mean
sample_variance = var(count_ones) %Sample Variance
[h,p] = chi2gof(count_ones, 'Alpha', 0.1,'Ctrs', [15:1:35]) %Test goodness-of-fit with Normal distribution
end