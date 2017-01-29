function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
for i = 1:m 
    zix = theta'*X(i,:)';
    hix = sigmoid(zix);
    costi = y(i)*log(hix)+(1-y(i))*log(1-hix);
    gradi = (hix - y(i))*X(i,:);    
    J = J + costi;
    grad = grad + gradi';
end
n = length(theta);
penalty = 0;
penaltyGrad = zeros(size(theta));
for j = 2:n
    penalty = penalty + lambda*theta(j)^2;
    penaltyGrad(j) = penaltyGrad(j) + lambda*theta(j);
end
J = -J/m + penalty/(2*m);
grad = grad./m+penaltyGrad./m;


% =============================================================

end
