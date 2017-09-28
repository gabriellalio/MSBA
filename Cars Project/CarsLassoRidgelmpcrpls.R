#ATTEMPT at LASSO/RIDGE/PLS/PCR
library(Metrics)
#normal lm

Cars = read.csv("Cars.csv")
attach(Cars)
dim(Cars)
fix(Cars)

set.seed(4)
train = sample(1:29466, (29466/3)*2)
test = (-train)

Cars.train = Cars[train, ]
Cars.test = Cars[test, ]

#attempt#1
lm.fitcars = lm(price~ ., data = Cars.train)
summary(lm.fitcars)
pred2 = fitted(lm.fitcars, data=Cars.test)
rmse(Cars.test$price, pred2)
plot(lm.fitcars, col="burlywood")

#looking at the price
hist(price)
mean(price)


#attempt #2

lm.fitcars2 = lm(price~ trim + condition +mileage + year + dispacement + region + wheelType + wheelSize, data=Cars.train)
summary(lm.fitcars2)
plot(lm.fitcars)
#patterns in the plots

lm.pred2 = fitted(lm.fitcars2,data= Cars.test)
rmse(Cars.test$price, lm.pred2)



#RIDGE ATTEMPT--> YIELDED THE BEST
library(glmnet)
grid=10^seq(10,-10, length =100)

trainridge = model.matrix(price ~ ., data = Cars.train)
testridge = model.matrix(price~ ., data = Cars.test)
Yvariabletrain = Cars.train$price
Yvariabletest = Cars.test$price

#alpha= 0 is ridge alpha = 1 is Lasso
ridge.mod= glmnet(trainridge, Yvariabletrain ,alpha=0, lambda=grid, thresh = 1e-12, standardize=TRUE)
crossfoldridge = cv.glmnet(trainridge, Yvariabletrain, alpha = 0, lambda = grid, thresh = 1e-12)
plot(crossfoldridge)

pickedlambda = crossfoldridge$lambda.min
pickedlambda

ridge.pred = predict(ridge.mod, s=pickedlambda, newx=testridge)
mse = mean((ridge.pred - Yvariabletest)^2)
rmse = sqrt(mse)
rmse

#LASSO ATTEMPT
## FOCUS ON LASSO, find which variables to take out and then re-run the linear regression
trainlasso = model.matrix(price ~ ., data = Cars.train)
testlasso = model.matrix(price~ ., data = Cars.test)
grid=10^seq(10,-10, length =100)

lasso.mod = glmnet(trainlasso, Yvariabletrain, alpha = 1, lambda = grid, thresh = 1e-12, standardize = TRUE)
summary(lasso.mod)
plot(lasso.mod, xlab="Lambda")
crossfoldlasso = cv.glmnet(trainlasso, Yvariabletrain, alpha = 1, lambda = grid, thresh = 1e-12)
plot(crossfoldlasso)

lassolambda = crossfoldlasso$lambda.min
lassolambda

lasso.pred = predict(lasso.mod, s=lassolambda, newx = testlasso)
mse = mean((lasso.pred - Yvariabletest)^2)
rmse = sqrt(mse)
rmse

#options(scipen=99)
lasso.coe = predict(lasso.mod, s=lassolambda, type = "coefficients")
lasso.coe
write.csv(lasso.coe, file = "Coefficents.csv")


