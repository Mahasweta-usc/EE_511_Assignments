simulations = [10,100,1000]; %Number of simulations
for i = 1:3
     x = zeros(simulations(i),1); initialize x
     for j = 1:simulations(i)
         zl = randn; %Draw the Zs
         z2 = randn;
         z3 = randn;
         z4 = randn;
         x(j, 1) = zl^2 + z2.2 + z3s2 + z4'.2; %assign x
     end
     [h,stats] = cdfplot(x); %Plot emperical CDF using cdfplot
     x = sort(x); %sort x to obtain percentiles
     cdf plot (x);
     hold on %overlay actual CDF
     plot (chi 2cdf (0:16,4) , ); %red indicates actual CDF
     title(strcat('Emperical and Actual comparision for n = .,int2str(simulations(1)))'); 
     xlabel('x');
     ylabel('F(x)');
     saveas (gcf , strcat ( figure. int2str(i), png. ) ) %save figure
     close all
     disp('25th percentile is:'); 
     x = sort(x);
     x(ceil(simulations(1).0.25)) %25th percentile of X
     disp('Theoretical 25th percentile is:');
     chi2inv(0.25,4) 525th percentile of chi-sg
     disp('50th percentile is:'); 
     x(ceil(simulations(i)*0.5)) %50th percentile of X
     disp('Theoretical 50th percentile is:');
     chi2inv(0.5,4) %50th percentile of chi-sg
     disp('90th percentile is:'); 
     x(ceil(simulations(i)*0.9)) %9oth percentile of X
     disp('.Theoretical 90th percentile is:');
     chi2inv(0.9,4) %90th percentile of chi-sg
         points  stats.min:stats.rnax;
    f =zeros(length(points),1); %G,lvenko-Cante,,1
    for k   1:length(points)
        I   0;
        for j = 1:sirnulations(i)
            if ((j) ‹. points(k)) If data less than the point

                I   I + 1; %Update indicator
            end
            f(k)
        end
    end
    f=                    %CDF values
    g   chi2cdf (points,4); %actual CDF
    difference  abs(g. -f); %Calculate difference 
    disp('Maxiniuni Deviation from theoretical.'); 
    rnax(difference) %Maximum deviation'
end