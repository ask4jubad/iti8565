
N = 100;

alldata = [];


% 1. uniform
uniform = [(rand(N,1)-0.5)*10, (rand(N,1)+1)*10];

% 2. gaussian
mu = [0, 0];
sigma = eye(2);
gaussian = mvnrnd(mu, sigma, N);
theta = pi/5;
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
S = diag([10, 1]);
T = R*S;
gaussian = gaussian * T';

% 3. circle
mu = [10, -10];
sigma = 5*eye(2);
circle = mvnrnd(mu, sigma, N);

% 4. Sine wave
sinewavex = linspace(0,10,100)-17;
sinewavey = 5*sin(sinewavex);
sinewave = transpose([sinewavex; sinewavey]);

% 5. Just circle
theta = 0:(2*pi)/N:2*pi;
theta_length = length(theta);
for i = 1:theta_length
    justcircle(i,1) = 5*cos(theta(i));
    justcircle(i,2) = 5*sin(theta(i)) -10;
end

for i = 1:100
    alldata = [alldata; uniform(i,:), 1];
    alldata = [alldata; gaussian(i,:), 2];
    alldata = [alldata; circle(i,:), 3];
    alldata = [alldata; sinewave(i,:), 4];
    alldata = [alldata; justcircle(i,:), 5];
end


scatter(alldata(:,1), alldata(:,2));
