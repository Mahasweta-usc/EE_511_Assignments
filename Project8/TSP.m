n = 48;
%% Simulated annealing algorithm
distance = pdist2(city, city);
% Parameters
num_iter = 1000; % number of iterations
c = 1;
% Initial path p
p = 1:n;
% Initial length of p
len = 0;
for a1 = 1:n-1
    len = len + distance(p(a1),p(a1+1));
end
len = len + distance(p(n),p(1));

% Save the paths and lengths
pathHistory = zeros(num_iter,n);
lenHistory = zeros(1,n);

% Plotting intial path
figure(1)
plot(city(:,1), city(:,2), 'ro');
xlim([min(city(:,1)) max(city(:,1))]);
ylim([min(city(:,2)) max(city(:,2))]);
hold on
line(city([p(:); p(1)],1), city([p(:); p(1)],2));
title('Initial path');
hold off

count = 0;

while(count<num_iter)
    count = count + 1;
    % Create path p2 by randomly swap two cities
    %chose any two of the n cities at random
    swap_index = randsample(n,2);
    p2 = p;
    %swap them
    temp = p2(swap_index(1));
    p2(swap_index(1)) = p2(swap_index(2));
    p2(swap_index(2)) = temp;
    % Cost of p2
    %calculate cost of new path
    len2 = 0;
    for a1 = 1:n-1
        len2 = len2 + distance(p2(a1),p2(a1+1));
    end
    len2 = len2 + distance(p2(n),p2(1));

    q = (1+count)^((len - len2)/c);
    
    if len2 - len <= 0
        p = p2;
        len = len2;
    else
        if rand <= q
            p = p2;
            len = len2;
        end
    end
    pathHistory(count,:) = p;
    lenHistory(count) = len;
end

figure(2)
plot(1:num_iter, lenHistory, 'linewidth',2);
title('Length of path in each iteration')

figure(3)
plot(city(:,1), city(:,2), 'ro');
xlim([min(city(:,1)) max(city(:,1))]);
ylim([min(city(:,2)) max(city(:,2))]);
hold on
line(city([p(:); p(1)],1), city([p(:); p(1)],2));
title('Final path of TSP using simulated annealing');
hold off