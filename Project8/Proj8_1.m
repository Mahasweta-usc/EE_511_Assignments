%initialize vector. Xi independent exponentials with mean 1
v = exprnd(1,[3,1]);
%1000 samples drawn
samples = zeros(1000,3);
while(v(1) + 2*v(2) + 3*v(3) > 1)
    v = exprnd(1,[3,1]);
end
%drawing each sample
for i = 1:1000
   
    samples(i,:) = v;
   index = randsample(3,1);
   %keeping other Xi fixed, one is changed
   v(index) = exprnd(1);
   %sampling based on magrinal P(Xi|Xj) 
     while(v(1) + 2*v(2) + 3*v(3) > 1)
        v(index) = exprnd(1);
    end
end
expectance = mean(samples,1);
