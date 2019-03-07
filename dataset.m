clear;
clc;

N=9;

K = 500;
rng('default');
Y = rand(K, 1);

X1= Y/4;
X2= rand(K, 1);
X3 = X1+X2;
X4= 2*Y + .6;
X5= 2*(X2+X4);
X6= linspace(1, 90, 500)';
X7= X4 + pi;
X8= 5 * ones(K,1);
X9= mvnrnd(3.57, cov(Y),500);

X = [X1 X2 X3 X4 X5 X6 X7 X8 X9];

save('X_data.mat','X');
save('Y_data.mat','Y');
expo

coef = mvregress(X, Y);
disp(coef);


