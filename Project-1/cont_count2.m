function [prev] = cont_count2(R)
len = length(R); %length of sample
prev = zeros(len,1); %initialize. Holds lengths of all runs.
current = 1; %current represents length of run currently being counted
counter = 1; %counts number of runs.
for i = 1:(len - 1)
if(R(i,1) == 1 && R(i + 1) == 1) %if current and next element are '1'
current = current + 1; %increment current
if(i == len - 1) %If at end of R
prev(counter,1) = current; %store current to prev
end
end
if(R(i,1) == 1 && R(i + 1) ~= 1) %if run has ended/only one '1'
prev(counter,1) = current; %store current to prev
counter = counter + 1; %increment counter
current = 1; %reset current
end
end
end