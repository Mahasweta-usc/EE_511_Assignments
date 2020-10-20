alpha = [0.5,1,1.8,2.0]; %alpha values to be simulated
beta = [0,0.75]; %betas for distributions to be simulated
l = 10000; %sample length
for i = 1:2
    for j = 1:4
        r = stblrnd(alpha(j),beta(i),1,0,l,1); %Call stblrnd to generate 
        %stable distribution for given alpha/beta
        [frequency,x] = hist(r,1000); %generate histogram object for r
        pdf = stblpdf(linspace(min(r),max(r),10000),alpha(j),beta(i),1,0); %obtain pdf for range of values generated
        %by stblrnd
        pdf = pdf/sum(pdf); %normalize pdf
        bar(x,frequency/sum(frequency),'y') %plot sample histogram
        hold on
        plot(linspace(min(x),max(x),10000),pdf,'r') %overlay pdf
        xlabel('sample values')
        ylabel('frequency')
        title(['Histogram and PDF for Alpha = ',num2str(alpha(j)),'Beta = ',num2str(beta(i))]);
        figure(2)
        plot(1:l,r) %timeseries plot
        xlabel('Sample Number')
        ylabel('Sample Value')
        pause
    end
end