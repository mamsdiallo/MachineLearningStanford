function [J, grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
K = size(y, 1);
J = 0;
% Input Layer 1: m x n - m nb of examples, n number of parameters
a1 = X;
% add bias 1 to a1. m x n + 1
a1 = [ones(m, 1) a1];
% Theta1 i,j - i destination node, j source node
% size : 25 x n+1
Z2 = a1*Theta1';
% Layer 2
a2 = sigmoid(Z2);
% add bias
a2 = [ones(m, 1) a2];
% Theta2 i,j - i dest node, j source node.
% size : 10 * 26
Z3 = a2*Theta2';
% Layer 3
a3 = sigmoid(Z3);
for i=1:m
    Y = zeros(1,num_labels);
    k = y(i);
    Y(k)=1;
    hk = a3(i,:);
    tmp = 0;
    for k=1:num_labels
        tmp = tmp+Y(k)*log(hk(k))+(1-Y(k))*log(1-hk(k));
    end
    J = J+tmp;%sum(tmp);%  + lambda*(sum(temp.*temp))/(2*m);
end
% Theta1: sum of squared elements
n1 = size(Theta1,1);
n2 = size(Theta1,2);
temp = 0;
for i=1:n1
    for j=2:n2
        temp = temp + Theta1(i,j)*Theta1(i,j);
    end
end

%temp(1) = 0;   % because we don't add anything for j = 0
n1 = size(Theta2,1);
n2 = size(Theta2,2);
for i=1:n1
    for j=2:n2
        temp = temp + Theta2(i,j)*Theta2(i,j);
    end
end
Jreg = temp;
J = -J/m+lambda*Jreg/(2*m); 
dTwoij = 0;
dOneij = 0;
Y = zeros(m,num_labels);
for i=1:m
    % Layer 3:
    % For each output unit k in layer 3
    k = y(i);
    Y(i,k)=1;
end
d3 = a3 -Y;
sigG = sigmoidGradient(Z2);
v1 = (Theta2'*d3');
v2 = (sigmoidGradient(Z2))';
v1 = v1(2:end,:);
d2 = (v1.*v2)';
% Compute Delta1
% ?(l) = ?(l) + ?(l+1)(a(l))T
Delta1 = (a1'*d2)';
Delta2 = (a2'*d3)';
% Correct with regularization
n1 = size(Theta1,1);
Temp1 = Theta1;
Temp1(:,1) = zeros(n1,1);
n2 = size(Theta2,1);
Temp2 = Theta2;
Temp2(:,1) = zeros(n2,1);
Theta1_grad = Delta1/m+lambda*Temp1/m;
Theta2_grad = Delta2/m+lambda*Temp2/m;
% Correct with regularization
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
