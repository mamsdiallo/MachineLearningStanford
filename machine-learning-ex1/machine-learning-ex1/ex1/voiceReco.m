%% Machine Learning Gender Recognition by Voice
% The following acoustic properties of each voice are measured and included within the CSV:
% 
% meanfreq: mean frequency (in kHz)
% label: male or female

%% Initialization
clear ; close all; clc

%% ==================== Part 1: Basic Function ====================
% Complete warmUpExercise.m 
data = csvread('voiceUnivariate.csv',2);
X = data(:, 1); y = data(:, 2);


%% ======================= Part 2: Plotting =======================
fprintf('Plotting Data ...\n')
m = length(y); % number of training examples

% Plot Data
% Note: You have to complete the code in plotData.m
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =================== Part 3: Gradient descent ===================
fprintf('Running Gradient Descent ...\n')

X = [ones(m, 1), data(:,1)]; % Add a column of ones to x
theta = zeros(2, 1); % initialize fitting parameters

% Some gradient descent settings
iterations = 1500;
alpha = 0.01;

% compute and display initial cost
computeCost(X, y, theta)

% run gradient descent
theta = gradientDescent(X, y, theta, alpha, iterations);

% print theta to screen
fprintf('Theta found by gradient descent: ');
fprintf('%f %f \n', theta(1), theta(2));

% Plot the linear fit
hold on; % keep previous plot visible
plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')
hold off % don't overlay any more plots on this figure

% Predict values for population sizes of 35,000 and 70,000
%predict1 = [1, 3.5] *theta;
%fprintf('For population = 35,000, we predict a profit of %f\n',...
%    predict1*10000);
%predict2 = [1, 7] * theta;
%fprintf('For population = 70,000, we predict a profit of %f\n',...
%    predict2*10000);

fprintf('Program paused. Press enter to continue.\n');
pause;
