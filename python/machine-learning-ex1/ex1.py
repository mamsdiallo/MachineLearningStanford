# -*- coding: utf-8 -*-
"""
Created on Thu Jan 22 2017

@author: Diallo
"""
# We can use the pandas library in python to read in the csv file.
import pandas as pd
#for numerical computaions we can use numpy library
import numpy as np

# warmup import 
#from WarmupExercise.py import warmUpExercise
def warmUpExercise():
    A = np.identity(3)
    return A

print warmUpExercise()

print "\n Plotting Data ...\n"

# This creates a matrix.
mat = np.loadtxt("ex1data1.txt", delimiter=",")
x = mat[:,0]

# number of training examples
m = len(mat)
o = np.ones((m,1))
#X = np.concatenate(o,x)