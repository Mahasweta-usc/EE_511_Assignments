sample = data(:,1); %contains the data for the waiting times 
sample_15 = data(1:15,1); %first 15 waiting times
%Part 1
x_bar 15 = mean(sample_15); %sample mean for n = 15
s 15 = std(sample_15); %sample standard deviation for n = 15
stat_ciupper_15 = x_bar_15 + tinv(0.975,14)*(s_15/sgrt(15)); %statist., CI uPPerlimit by t-test 
stat_ci_lower_15 = x_bar_15 + tinv(0.025,14)*(s_15/sgrt(15)); %statist., CI ,ower,imit 
disp('Statistical test CI: ')
interval_width_si_15 = stat_ci_upper_15 - stat_ci_lower_15 Width of CI

boot_means_15 = sort(bootstrp(1000,@mean,sample_15)); %BootstraPPing and sorting 
Upper_bound_means_15 = boot_means_15 ( 975,1) ; %Upperlimit
Lower_bound_means_15 = boot_means_15(25,1); %lowerlimit
disp('Bootstarp CI')
CI_mean_15 Upper_bound_means_15 - Lower_bound_means_15 %Bootstrap CI

%Part 2
x_bar = mean(sample); %sample mean
s = std(sample); %samP,e STD
stat ci upper = x bar + norminv(0.975,0,1)*(s/sgrt(272)); %statist., CI uPPer,imit by .-score 
stat_ci_lower = x_bar + norminv(0.025,0,1)*(s(:,1)/sgrt(272)); %statist., CI Cower,imit by z-score 
disp('Statistical test CI: ')
interval_width_si F stat_ci_upper - stat_ci_lower %width of CI

boot_means = sort(bootstrp(1000,@mean,sample)); %BootstraPPing and sorting 
Upper_bound_means = boot_means(975,1); %Upperlimit
Lower_bound_means = boot_means (25,1); %lowerlimit
disp('Bootstarp CI' )1
CI_mean G Upper_bound_means - Lower_bound_means %Bootstrap CI