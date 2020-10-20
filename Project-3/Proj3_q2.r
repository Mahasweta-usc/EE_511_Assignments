sub_intervals <- 60*60*500; #intervals of 0.05 sec
bernoulli_arrivals <- 0;
simulations = 50;
results <- vector("list", simulations) 
results_dit <- vector("list",simulations)
for(k in 1:simulations)
{
  bernoulli_arrivals <- 0;
for(j in 1:sub_intervals)
{
  j <- j + 1;
  if(rbinom(1,1,120/sub_intervals))
    bernoulli_arrivals <- bernoulli_arrivals + 1;
}
  results[k] <- bernoulli_arrivals;
  k <- k +1;
  
}
results = unlist(results);
jpeg('Q2.jpg')
hist(as.integer(results), main="Histogram of arrivals", xlab="No of arrivals", breaks= 20)
write.csv(results, file = "/home/tukai/Desktop/Proj3/results.csv")


sum <- 0;
for(k in 1:simulations)
{
poisson_success <- 0;
  u = runif(1, min = 0, max = 1);
  P <- exp(-120);
  F = P;
  i <- 0;
while(u > F)
{
  P <- P*(120)/(i+1);
  F <- F + P;
  i <- i + 1
}
results_dit[k] <- i;
sum <- sum + 1;
k <- k + 1;
}
results_dit = unlist(results_dit);
jpeg('plot_Q2_2.jpg')
hist(as.integer(results_dit), main="Histogram of Poisson arrivals", xlab="No of arrivals", breaks= 20)
write.csv(results_dit, file = "/home/tukai/Desktop/Proj3/results_dit.csv")


