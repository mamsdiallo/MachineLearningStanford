# -*- coding: utf-8 -*-
"""
Created on Thu Jan 19 21:15:02 2017

@author: Diallo
"""

# We can use the pandas library in python to read in the csv file.
import pandas as pd
#for numerical computaions we can use numpy library
import numpy as np


# This creates a pandas dataframe and assigns it to the data variable.
df = pd.read_csv("ex1data1.csv")

# Print the first 5 rows of the dataframe.
print df.head()
print df.shape

#Describe gives statistical information about numerical columns in the dataset
print df.describe()
print df.info()
