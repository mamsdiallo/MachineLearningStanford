X = [[1 1 1]' magic(3)];
y = [7 6 5]';
theta = [0.1 0.2 0.3 0.4]';
lambda = 0;
[J g] = linearRegCostFunction(X, y, theta, lambda);
fprintf(['Cost  %f \n'...
            '\n this value should be  1.3533\n'], J);
fprintf(['Gradient at theta = [0.1 0.2 0.3 0.4]:  [%f; %f;%f;%f] '...
         '\n(this value should be about [-1.4000; -8.7333; -4.3333;-7.9333])\n'], ...
         g(1), g(2),g(3),g(4));
lambda = 7;
[J g] = linearRegCostFunction(X, y, theta, lambda);
fprintf(['Cost  %f \n'...
            '\n this value should be 1.6917\n'], J);
fprintf(['Gradient at theta = [0.1 0.2 0.3 0.4]:  [%f; %f;%f;%f] '...
         '\n(this value should be about [-1.4000; -8.2667; -3.6333;-7.0000])\n'], ...
         g(1), g(2),g(3),g(4));
X = [1 2 3 4];
y = 5;
theta = [0.1 0.2 0.3 0.4]';
[J g] = linearRegCostFunction(X, y, theta, 7);