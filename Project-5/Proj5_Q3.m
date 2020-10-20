index = 200; % 2*N
convergence = 5000; %Number of generations simulated till convergence
variations = [101,151];
% 2: One A1, all A2
% 51: 50 A1, 150 A2
% 151: 150 A1, 50 A2
% 101: 100 A1 100 A2
% 201: 200 A1, O A2
for trials = 1:length(variations)
initial = zeros(1,201); %2N	copies	A1, 0	copies	A2
initial(variations(trials)) = 1; %create initial state with variations(trials) number of A1
intermediate = zeros(convergence, index + 1); %stores all intermediate state probabilities till convergence
trans = zeros(index+1,index+1); %initialize transition matrix
%Generate transition matrix by given formula
for i = 1:index+1
 for j = 1:index+1
 trans(i,j) = nchoosek(index,j-1)*power((i-1)/(index),j-1)*power((1-((i-1)/(index))),(index - j + 1)); %Bin(2N,j,i/2N)
 end
end
%initial state
intermediate(1,:) = initial;
%Find state probabilities till convergence. Each element of intermediate
% (i,j) indicates the probability of j A1's at the ith generation 
for i = 2:5000
    temp = final;
    intermediate(i,:) = intermediate(i-1,:)*trans;
    if all(ismembertol(intermediate(i,:),intermediate(i-1,:)) == 1) %check for convergence
        break
    end
end
intermediate(i,:)
i
pause
end