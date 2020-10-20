%Parameters initialization
sigma = [[3 -1 1];[-1 5 3];[1 3 4]];
mu = [1;2;3];
%Cholesky decomposition
A = chol(sigma);
%sample set
samples = zeros(10000,3);
%generation of samples
for i = 1:10000
    z = randn(3,1);
    samples(i,:) = (A'*z + mu)';
end
%Find sample mean and covariance to validate
A_exp = cov(samples)
mu_exp = mean(samples)