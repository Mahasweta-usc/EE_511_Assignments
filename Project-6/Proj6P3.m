

function [] = GMM(mu1,mu2,sigma1,sigma2,w1,w2)
samples_gmm = zeros(300,2);
for i = 1:300
   r = rand();
   q = randn(2,1);
  if(r < w1)
      samples_gmm(i,:) = (chol(sigma1)*q + mu1)';
  else
      samples_gmm(i,:) =  (chol(sigma2)*q + mu2)';
  end
end
tic
%Initialization
idx = kmeans(samples_gmm,2);
n = 300;
d = 2;
Y = zeros(n,d);
for i =1:n
    for j = 1:d
  if(idx(i) == j)      
  Y(i,j) = 1;
  else
      Y(i,j) = 0;
  end
    end
end

u = zeros(2,2);
sig = zeros(2,2,2);
L_old = 0;
iter = 0;
while(1)
    
for i = 1:d
    n_vect(i) = sum(Y(:,i));
end

w = n_vect/n;

u(:,1) = samples_gmm'*Y(:,1)/n_vect(1);

u(:,2) = samples_gmm'*Y(:,2)/n_vect(2);

sig = zeros(2,2,2);
for j = 1:d
    for i = 1:n
sig(:,:,j) = sig(:,:,j) + Y(i,j)*((samples_gmm(i,:) - u(:,j)')'*(samples_gmm(i,:) - u(:,j)'));
    end
sig(:,:,j) = sig(:,:,j)/n_vect(j);
end

for i = 1:n
    for j = 1:d
phi(i,j) = exp(-1/2*((samples_gmm(i,:) - u(:,j)')*inv(sig(:,:,j))*(samples_gmm(i,:) - u(:,j)')'));
phi(i,j) = (1./((2*pi)*(det(sig(:,:,j)))^(0.5)))*phi(i,j);
    end
end

L_new = mean(log(w*phi'));
if(abs(L_new - L_old) < 10^-10)
    break
end
L_old = L_new;

update = (w(1)*phi(:,1));
update = [update,(w(2)*phi(:,2))];

Y = update;
for i = 1:n
    normt = sum(Y(i,:));
       Y(i,1) = Y(i,1)/normt;
       Y(i,2) = Y(i,2)/normt;
end

end
toc
end