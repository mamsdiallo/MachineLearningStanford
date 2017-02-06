function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%
for i = 1:m 
    Hi = theta'*X(i,:)';
    Temp =( Hi-y(i))^2;
    gradi = (Hi - y(i))*X(i,:); 
    J = J+ Temp;   
    grad = grad + gradi';
end
temp = theta; 
temp(1) = 0;   % because we don't add anything for j = 0  
J = J/(2*m) + lambda*(sum(temp.*temp))/(2*m);
grad = grad/m + lambda*temp/m;

% =========================================================================

grad = grad(:);

end
