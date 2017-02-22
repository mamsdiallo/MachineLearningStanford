%% Machine Learning Online Class
% Year: the observation year.
% Month: the observation month.
% Temp: the difference in degrees Celsius between the average global 
% temperature in that period and a reference value. 
% This data comes from the Climatic Research Unit at the 
% University of East Anglia.
% CO2, N2O, CH4, CFC.11, CFC.12: 
% atmospheric concentrations of carbon dioxide (CO2), 
% nitrous oxide (N2O), methane  (CH4), trichlorofluoromethane 
% (CCl3F; commonly referred to as CFC-11) and dichlorodifluoromethane 
% (CCl2F2; commonly referred to as CFC-12), respectively. 
% This data comes from the ESRL/NOAA Global Monitoring Division.
% CO2, N2O and CH4 are expressed in ppmv 
% (parts per million by volume  -- i.e., 397 ppmv of CO2 means 
% that CO2 constitutes 397 millionths of the total volume of the atmosphere)
% CFC.11 and CFC.12 are expressed in ppbv 
% (parts per billion by volume). 
% Aerosols: the mean stratospheric aerosol optical depth at 550 nm. 
% This variable is linked to volcanoes, as volcanic eruptions result in new particles being added to the atmosphere, which affect how much of the sun's energy is reflected back into space. This data is from the Godard Institute for Space Studies at NASA.
% TSI: the total solar irradiance (TSI) in W/m2 
% (the rate at which the sun's energy is deposited per unit area). 
% Due to sunspots and other solar phenomena, the amount of energy 
% that is given off by the sun varies substantially with time. 
% This data is from the SOLARIS-HEPPA project website.
% MEI: multivariate El Nino Southern Oscillation index (MEI), 
% a measure of the strength of the El Nino/La Nina-Southern Oscillation 
% (a weather effect in the Pacific Ocean that affects global temperatures). 
% This data comes from the ESRL/NOAA Physical Sciences Division.
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = csvread('climate_change.csv',2);
X = data(:,3:10); y = data(:, 11);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.1;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(9, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
%sigma = [1 sigma]';
%mu = [1 mu]';
%theta = sigma.*theta+mu; % You should change this
% x = x_bar + z * s. 
% X represents the raw score, 
% x_bar is the mean, 
% z is the z-score and s is the standard deviation
%temp = mu+[1650;3].*sigma
%x = mu+[1650;3].*sigma
%price = [1;x]'*theta;
temp = [1, -0.666,385.56,1812.88,322.182,244.204,535.005,1365.6926,0.0046] *theta;

% ============================================================
% MEI: multivariate El Nino Southern Oscillation index (MEI),
% atmospheric concentrations of carbon dioxide (CO2), 
% expressed in ppmv 
% (parts per million by volume  -- i.e., 397 ppmv of CO2 means 
% that CO2 constitutes 397 millionths 
% of the total volume of the atmosphere)
% actual value: 0.33
fprintf(['Predicted temp of a MEI = 0.666, CO2 = 385.56' ...
         '(using gradient descent):\n $%f\n'], temp);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
data = csvread('climate_change.csv',2);
X = data(:,3:10); y = data(:, 11);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
%price = theta'*[1;1650;3]; % You should change this
temp = [1,-0.666,385.56,1812.88,322.182,244.204,535.005,1365.6926,0.0046]*theta;

% ============================================================
% actual value: 0.33
fprintf(['Predicted temp of a -0.666,385.56 ' ...
         '(using normal equations):\n %f\n'], temp);

% actual value: 0.394
temp = [1, -0.621,384.13,1812.37,322.013,244.225,534.906,1365.7065,0.0048]*theta;
fprintf(['Predicted temp of a -0.621,384.13,1812.37, ' ...
         '(using normal equations):\n %f\n'], temp);
