Proj3_q3 <- function(simulations)
{
  results <- vector("list", simulations) 
for(k in 1:simulations)
{ 
  sum <- 0;
  counter <- 0;
  while(sum < 4)
  {
    u = runif(1, min = 0, max = 1);
    sum <- sum + u
    counter <- counter + 1;
  }
  k <- k + 1;
  results[k] <- counter;
}
  results <- unlist(results);
  hist(as.integer(results), main="Histogram for minimum trials for sum of four", xlab="Value of N", breaks=10)
  cat("Calculate sample mean for ",simulations, "simulations is ", mean(results))
  return(results)
}

