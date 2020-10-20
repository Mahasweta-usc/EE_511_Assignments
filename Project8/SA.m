function [X,Y,F] = SA(N)
%% Contour Plotting
x1 = linspace(-500,500);
x2 = linspace(-500,500); 
[X1,X2] = meshgrid(x1,x2); 
%define function
f =  418.9829*2 - X1.*sin(sqrt(abs(X1))) - X2.*sin(sqrt(abs(X2))); % Compute f(x,y) in matrix form
%mesh plot and %contour plot
figure(1)
contour(X1,X2,f); % Plot a contour plot
colorbar;
xlabel('X1');
ylabel('X2');
figure(2)
mesh(X1,X2,f); % Plot a mesh plot
colorbar;
xlabel('X1');
ylabel('X2');
zlabel('Z');
xlim([-500 500]);
ylim([-500 500]);

%Simulated Annealing
%initialize coordinates and Tempareture
T = zeros(N,1);
T(1) = 100;
X = zeros(N,1);
Y = zeros(N,1);

for t = 1:N
    %jump distribution
    temp1 = X(t) + normrnd(0,70);
    temp2 = Y(t) + normrnd(0,70);
    %limiting new points in the range [-500,500]
    while(abs(temp1) > 500 || abs(temp2) > 500)
           temp1 = X(t) + normrnd(0,70);
           temp2 = Y(t) + normrnd(0,70);
    end
    
    %calculate function at old point and new point
    F1 = 418.9829*2 - temp1.*sin(sqrt(abs(temp1))) - temp2.*sin(sqrt(abs(temp2)));
    F2 = 418.9829*2 - X(t).*sin(sqrt(abs(X(t)))) - Y(t).*sin(sqrt(abs(Y(t))));
    %evaluate boltzmann
    alpha = exp(F2 - F1)/T(t);
    %if function value smaller at new point/alpha probability of selecting
    %new point
    if((F1 <= F2) || (rand(1) < alpha))
        X(t+1) = temp1;
        Y(t+1) = temp2;
        
    else
        X(t+1) = X(t);
        Y(t+1) = Y(t);
    end
    %cooling schedule(polynomial)
    T(t+1) = T(t)*log(t+1);
end
%Display results after N iterations
display('The minimum values of X* and Y* are:');
display(X(N));
display(Y(N));
display('The minimum values of the surface is:');
F = 418.9829*2 - X(N).*sin(sqrt(abs(X(N)))) - Y(N).*sin(sqrt(abs(X(N))));
display(418.9829*2 - X(N).*sin(sqrt(abs(X(N)))) - Y(N).*sin(sqrt(abs(X(N)))));
end