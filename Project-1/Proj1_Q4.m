function Proj1_Q4(N) %N = User specified number of '1's required
tally = []; %Records number of trials till N '1's
for i = 1:1000 %1000 repetitions
count = 1; %tracks number of trials required each iteration
record = []; %Lists all the outcomes of current iteration
while(count)
R = binornd(1,0.5,1,1); %Bernoulli as Binomial with n = 1, p = 0.5
record = [record;R]; %append outcome to record
ones_t = sum(record) %stores number of ones obtained so far
count = count + 1; %updates count
if(ones_t >= N) %If requisite number of '1's have been reached
disp('Number of trials: ') %Display results
count
break %Move to next iteration
end
end
tally = [tally; count] %append number of trials
end
figure(2)
sample_mean = mean(tally) %compare sample param