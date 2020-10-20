%initialize sample matrix
samples_gmm = zeros(1000,1);
%generate samples
for i = 1:1000
  r = rand();
  
  if(r < 0.4)
      %0.4 weight
      samples_gmm(i) = -1 + randn();
  else
      %0.6 weight
      samples_gmm(i) =  1 + randn();
  end
end
%obtain histogram
[h w] = hist(samples_gmm,70,'Normalization','probability');
%plot histogram
bar(w,h/1000)
%estimate parameters
GMModel = fitgmdist(samples_gmm,2);
%obtain pdf
y = pdf(GMModel,w');
hold on
%overlay pdf
plot(w,y/sum(y),'r');
title('Sample histogram and pdf overlay');
