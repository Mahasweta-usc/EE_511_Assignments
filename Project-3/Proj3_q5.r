aux_dist = 0.05*c(rep.int(1, 20));
p_dist = c(0.06,0.06,0.06,0.06,0.06,0.15,0.13,0.14,0.15,0.13, c(rep.int(0,10)));
accept <- 0;
reject <- 0;
c <- 3;
valid_outcomes = vector("list",1000);
for(k in 1:1000)
{
  y = sample(1:1:20, size = 1, replace = TRUE, prob = aux_dist);
  i <- as.integer(y);
  u = runif(1, min = 0, max = 1);
  while(u >= (p_dist[i]/(c*aux_dist[i])))
  {
    y = sample(1:1:20, size = 1, replace = TRUE, prob = aux_dist);
    i <- as.integer(y);
    u = runif(1, min = 0, max = 1);
    reject <- reject + 1;
    
  }
  valid_outcomes[k] <- y;
  accept <-accept + 1;
  k <- k + 1;
}
efficiency = accept/(accept + reject);
print(efficiency)
valid_outcomes = unlist(valid_outcomes);
print(mean(valid_outcomes))
print(var(valid_outcomes))
hist(as.integer(valid_outcomes), main="Histogram for occurences", xlab="Sequence values Generated",breaks = 21)