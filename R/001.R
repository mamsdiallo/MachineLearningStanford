# SETUP 
Sys.setlocale("LC_ALL", "C")


# Part 1: Basic Function
print ("Running warmUpExercise")
# 5x5 Identity Matrix
A = diag(3)

print(A)

# Part 2: Plotting
print("Plotting Data ...\n")
# SET FOLDER
setwd("C:\Users\Diallo\Documents\MachineLearningStanford\R")

# READ INPUT FILE
df = read.csv("MachineLearningStanford/R/ex1data1.csv")

# rename col names
colnames(df)<- c("X","y")

x = df$X
y = df$y
#number of training examples
m = length(y)

# plot data
plot(x,y)

# Part 3: Gradient descent
# X = [ones(m, 1), data(:,1)]; % Add a column of ones to x
X = cbind(1,x)
# initialize fitting parameters
theta = rep(0,2)

# Some gradient descent settings
iterations = 1500
alpha = 0.01
J = 0


for (i in 1:m) { 
  Hi = theta %*% X[i,]
  Temp =( Hi-y[i])^2;
  J = J+ Temp;
}
J = J/(2*m)

J_history = rep(0,iterations)
for (iter in 1:iterations) {
  Temp = rep(0,2);
  for (i in 1:m) {
    for (j in 1:2) {
      Hix = theta %*% X[i,]
      Temp[j] = Temp[j]+(Hix - y[i])*X[i,j]
    }
  }
  
  theta = theta-alpha %*% Temp/m
  for (k in 1:m) { 
    Hi = theta %*% X[k,]
    Temp =( Hi-y[k])^2;
    J = J+ Temp;
  }
  J = J/(2*m)
  
  J_history[iter] = J;
}

plot(X[,2], X %*% theta)