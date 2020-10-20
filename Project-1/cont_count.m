function [prev] = cont_count(R) %prev: contains the maximum length of any run of ‘1’s so far
len = length(R); %len = number of trials in the experiment
prev = 0;
current = 1; %current = length of the run being currently counted
for i = 1:(len - 1) %Traverse through the outcomes
if(R(i,1) == 1 && R(i + 1) == 1) %If current and next occurrence is ‘1’
current = current + 1; %increment current
if(current > prev) %If current length greater than any previously recorded run
prev = current; %set prev as current
end
else
current = 1; % If the run has ended, reset current
end
end
end