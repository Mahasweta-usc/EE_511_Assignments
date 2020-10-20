v1 <- c(rep.int(1, 119)); #create vector of ones
v2 <- c(rep.int(0L,6)); #create vector of zeros
v <- c(v1,v2); #merge them to create a vector of 120 '1's and 5 '0's
#'1's represent good chips, '0's represent bad chips
count <- 0; # tracks number of samples with a '0' in them
i <- 0; #no of experiments
while(i < 10000)
{
  result <- sample(v, 5, replace = FALSE, prob = NULL); #draw a sample
  #of 5 elements without replacements
if(0 %in% result) #if sample has a '0'
{
  count <- count + 1; #update count
}
  i <- i + 1;
}
print(count/i); #rough probability estimate


 #Finding smallest N for 95% success



N_values = vector("list",1000); #to store the values of N
for(exp in 1:5) #repeated evaluation of N
{
j <- 0;
for(j in 1:125) #Checking for N from 1 to 125
{
  i <- 0;
  count <- 0;
while(i < 10000)
{
  result <- sample(v, j, replace = FALSE, prob = NULL); #draw a sample
  #of 5 elements without replacements
  if(0 %in% result) #if sample has a '0'
  {
    count <- count + 1; #update count
  }
  i <- i + 1;
}
  if(count/i >= 0.95) #if 95% success
  {
    break; #N = j
  }
  j <- j + 1;
    
}
N_values[exp] <- j; #j stores the latest N value
exp <- exp + 1;
}
N_values = unlist(N_values);
hist(as.integer(N_values), main="Histogram for minimum trials for 95% success", xlab="Value of N", breaks= 10)

