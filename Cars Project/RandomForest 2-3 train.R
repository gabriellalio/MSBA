library(randomForest)
##RANDOM FOREST MODELS
Cars = read.csv("Cars.csv")
dim(Cars)
#bagging since we are using all the variables at every split
set.seed(1)
train = sample(1:nrow(Cars), 19644)
cars.test = Cars[-train, "price"]

##Random forest trees= 200 , mtry=6

rf.cars = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=6, importance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
plot(yhat.rf, cars.test)
abline(0,1)
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse# 6720.211

importance(rf.cars)
varImpPlot(rf.cars)
##important variables are mileage, year, condition
#dispacement, trim

##Random forest trees= 200 , mtry=6, nodesize=5

set.seed(1)
rf.carsn4 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=4, importance=TRUE)
rf.carsn4
names(rf.carsn4)
rf.carsn4$terms


yhat.rfn4 = predict(rf.carsn4, newdata = Cars[-train,])
plot(yhat.rfn4, cars.test)
abline(0,1)
mse = mean((yhat.rfn4 - cars.test)^2)
rmse = sqrt(mse)
rmse#6689.817

importance(rf.carsn4)
varImpPlot(rf.carsn4)
##important variables are mileage, year, condition
#dispacement, trim


##Random forest trees= 200 , mtry=4, nodesize=20

set.seed(1)
rf.carsn4n20 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=4, nodesize=20, importance=TRUE)
rf.carsn4n20

yhat.rfn4n20 = predict(rf.carsn4n20, newdata = Cars[-train,])
plot(yhat.rfn4n20, cars.test)
abline(0,1)
mse = mean((yhat.rfn4n20 - cars.test)^2)
rmse = sqrt(mse)
rmse#6649.087

importance(rf.carsn4n20)
varImpPlot(rf.carsn4n20)
##important variables are mileage, year, condition
#dispacement, trim



##Random forest trees= 200 , mtry=6, nodesize=20


rf.carsn6n20 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=6, nodesize=20, importance=TRUE)
rf.carsn6n20

yhat.rfn6n20 = predict(rf.carsn6n20, newdata = Cars[-train,])
plot(yhat.rfn6n20, cars.test,  pch= 1, cex.lab = 3)
abline(0,1)
mse = mean((yhat.rfn6n20 - cars.test)^2)
rmse = sqrt(mse)
rmse

plot(yhat.rfn6n20, (yhat.rfn6n20-cars.test), col=ifelse((yhat.rfn6n20)>105000, "burlywood", "black"), xlab= "Predicted", ylab='Residuals', cex.lab=1.2, main= "Predicted vs. Residuals Plot")
options(scipen=999)
importance(rf.carsn6n20)
varImpPlot(rf.carsn6n20)
##important variables are mileage, year, condition
#dispacement, trim



##Random forest trees= 200 , mtry=6, nodesize=40

set.seed(1)
rf.carsn6n40 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=6, nodesize=40, importance=TRUE)
rf.carsn6n40

yhat.rfn6n40 = predict(rf.carsn6n40, newdata = Cars[-train,])
plot(yhat.rfn6n40, cars.test)
abline(0,1)
mse = mean((yhat.rfn6n40 - cars.test)^2)
rmse = sqrt(mse)
rmse#

importance(rf.carsn6n40)
varImpPlot(rf.carsn6n40)
##important variables are mileage, year, condition
#dispacement, trim


##Random forest trees= 200 , mtry=4, nodesize=40

set.seed(1)
rf.carsn4n40 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=4, nodesize=40, importance=TRUE)
rf.carsn4n40

yhat.rfn4n40 = predict(rf.carsn4n40, newdata = Cars[-train,])
plot(yhat.rfn4n40, cars.test)
abline(0,1)
mse = mean((yhat.rfn4n40 - cars.test)^2)
rmse = sqrt(mse)
rmse#

importance(rf.carsn4n40)
varImpPlot(rf.carsn4n40)
##important variables are mileage, year, condition
#dispacement, trim





##Random forest trees=200 , mtry=4, nodesize=30

set.seed(1)
rf.carsn4n30 = randomForest(price~., data=Cars, ntree = 200, subset=train, mtry=4, nodesize=30, importance=TRUE)
rf.carsn4n30

yhat.rfn4n30 = predict(rf.carsn4n30, newdata = Cars[-train,])
plot(yhat.rfn4n30, cars.test)
abline(0,1)
mse = mean((yhat.rfn4n30 - cars.test)^2)
rmse = sqrt(mse)
rmse#

importance(rf.carsn4n30)
varImpPlot(rf.carsn4n30)
##important variables are mileage, year, condition
#dispacement, trim


##Random forest trees=100 , mtry=6, nodesize=30

set.seed(1)
rf.carsn6n30 = randomForest(price~., data=Cars, ntree = 100, subset=train, mtry=6, nodesize=20, importance=TRUE)
rf.carsn6n30

yhat.rfn6n30 = predict(rf.carsn6n30, newdata = Cars[-train,])
plot(yhat.rfn6n30, cars.test)
abline(0,1)
mse = mean((yhat.rfn6n30 - cars.test)^2)
rmse = sqrt(mse)
rmse#

importance(rf.carsn6n30)
varImpPlot(rf.carsn6n30)
##important variables are mileage, year, condition
#dispacement, trim








