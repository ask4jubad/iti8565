
N = 100; 

% uniform
uniform = [(rand(N,1)-0.5) *10, (rand(N,1)+0.5)*10]

% guassian
mu = [0, 0];
sigma = eye(2);
gaussian = mvnrnd(mu, sigma, N);
theta = pi/5;
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
S = diag([10, 1]);
T = R*S;
gaussian = gaussian * T';


% circle_jagged
mu = [10, -10];
sigma = eye(2);
circle = mvnrnd(mu, sigma, N);

% random
x = linspace(0,10, 100);
y = 5*sin(x);

%circle
py = 0:2*pi/N:2*pi;
py_length= length(py);
for i = 1:py
    newcircle(1,1) = 5*cos(py(i));
    newcircle(1,2) = 5*sin(py(i));
end

scatter scatter(x-17,y)



scatter(x-17,y)
hold on
scatter(uniform(:,1), uniform(:,2))
hold on
scatter(gaussian(:,1), gaussian(:,2))
hold on
scatter (circle(:,1), circle(:,2))