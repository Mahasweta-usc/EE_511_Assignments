
load('faith.mat');
tic
%K-means estimate
idx = kmeans(faith,2);
%Scatter plot of K-means clusters
figure(1)
A = faith(idx == 1,:);
plot(A(:,1),A(:,2),'x');
hold on
B = faith(idx == 2,:);
plot(B(:,1),B(:,2),'o');
pause

%initialize n as number of samples, d as no of GMM
n = 272;
d = 2;
%initialize paramters

Y = [zeros(136,1),ones(136,1)];
Y = [Y;[ones(136,1),zeros(136,1)]];
Y
u = zeros(2,2);
sig = zeros(2,2,2);
L_old = 0;
iter = 0;

while(1)
    %update n
for i = 1:d
    n_vect(i) = sum(Y(:,i));
end
%update weights
w = n_vect/n;
%update means
u(:,1) = faith'*Y(:,1)/n_vect(1);
u(:,2) = faith'*Y(:,2)/n_vect(2);

sig = zeros(2,2,2);
%update variance
for j = 1:d
    for i = 1:n
sig(:,:,j) = sig(:,:,j) + Y(i,j)*((faith(i,:) - u(:,j)')'*(faith(i,:) - u(:,j)'));
    end
sig(:,:,j) = sig(:,:,j)/n_vect(j);
end
%update phi
for i = 1:n
    for j = 1:d
phi(i,j) = exp(-1/2*((faith(i,:) - u(:,j)')*inv(sig(:,:,j))*(faith(i,:) - u(:,j)')'));
phi(i,j) = (1./((2*pi)*(det(sig(:,:,j)))^(0.5)))*phi(i,j);
    end
end
%calculate L
L_new = mean(log(w*phi'));
%if tolerance reached, terminate else continue
if(abs(L_new - L_old) < 10^-10)
    break
end
L_old = L_new;
%update phi
update = (w(1)*phi(:,1));
update = [update,(w(2)*phi(:,2))];
Y = update;
%normalize rows of phi
for i = 1:n
    normt = sum(Y(i,:));
       Y(i,1) = Y(i,1)/normt;
       Y(i,2) = Y(i,2)/normt;
end

end
toc
%overlay GMM contours
sigma = cat(3,sig(:,:,2),sig(:,:,1));
mu = zeros(2,2);
mu(:,1) = u(:,2);
mu(:,2) = u(:,1);
w2(1) = w(2);
w2(2) = w(1);
obj = gmdistribution(mu',sigma,w2);

hold on
ezcontour(@(x,y)pdf(obj,[x y]),[1.5 5.5],[40 180]);
title('K-means cluster with EM-GMM overlay')
xlabel('eruptions')
ylabel('wating')