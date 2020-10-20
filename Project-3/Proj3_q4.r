sum <- 0;
probn <- vector("list", 1000) 
for(k in 1:60)
{
  sum <- sum + 1/k;
  probn[k] <- 1/k;
}
p <- 1/sum;
probn = unlist(probn);
probn = probn*p;
prob60 = probn[60];
sequence = sample(1:1:60, size = 1000, replace = TRUE, prob = probn);
hist(sequence, main="Histogram for occurences in the sequences", xlab="Sequence values Generated", breaks= 60)

N_count <- vector("list",10000);
outcome <- 0;
for(k in 1:10000)
{
N <- 0;
outcome <- 0;
while(outcome != 60)
{
  outcome = sample(1:1:60, size = 1, replace = TRUE, prob = probn);
  N <- N + 1;
}
N_count[k] <- N
k <- k + 1;
}
N_count<- unlist(N_count)
hist(as.integer(N_count), main="Histogram for N60", xlab="Values of N60", breaks= 100)
cat("Sample mean = ",mean(N_count),"\n");
cat("Sample variance = ",var(N_count), "\n");
cat("Theoretical mean = ",1/prob60, "\n");
theoretical_variance = ((1/prob60)^2)*(1-prob60);
cat("Theoretical variance = ",theoretical_variance, "\n");
