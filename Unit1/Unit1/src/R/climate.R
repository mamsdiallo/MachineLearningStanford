# 
Sys.setlocale("LC_ALL", "C")

# libraries
library("dplyr")

# read file
climate <- read.csv("../")

# analysis
str(climate)

# training set
climateTrain <- subset(climate,Year<=2006)
str(climateTrain)
nrow(climateTrain)
train <- tbl_df(climateTrain)
# testing set
climateTest <- subset(climate,Year>2006)
str(climateTest)
nrow(climateTest)
test <- tbl_df(climateTrain)

# build FULL model
# variables
names(train)
climateLM <- lm(Temp ~ MEI+ CO2+ CH4+ N2O+ CFC.11+ CFC.12+ TSI+Aerosols,data=train)
summary(climateLM)

model2 <- lm(Temp ~ MEI+ TSI+ Aerosols+ N2O,data=train)
summary(model2)

md <- step(climateLM)

# use of prediction
tpredicted <- predict(md,newdata = test)
SSE <- sum((test$Temp - tpredicted)^2)
# SSE = sum((tst$readingScore - predt)^2)
# SSE
SSE
SST <- sum((test$Temp - mean(train$Temp))^2)
SST
1 - SSE/SST
