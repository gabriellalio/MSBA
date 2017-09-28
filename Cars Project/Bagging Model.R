
library(randomForest)

Cars = read.csv("Cars.csv")
dim(Cars)
#bagging since we are using all the variables at every split
train = sample(1:nrow(Cars), nrow(Cars)/2)
cars.test = Cars[-train, "price"]

#### BAGGING, TREES=25, #of variables tried at each split 13
set.seed(1)
bag.cars = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=25)
bag.cars


yhat.bag = predict(bag.cars, newdata = Cars[-train,])
plot(yhat.bag, cars.test)
abline(0,1)
mse = mean((yhat.bag-cars.test)^2)
rmse = sqrt(mse)
rmse##7069.943

##BAGGING TREES = 50, #of variables tried at each split 13

set.seed(1)
bag.cars = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=50)
bag.cars


yhat.bag = predict(bag.cars, newdata = Cars[-train,])
plot(yhat.bag, cars.test)
abline(0,1)
mse = mean((yhat.bag-cars.test)^2)
rmse = sqrt(mse)
rmse ##7046.484

##BAGGING TREES = 100, #of variables tried at each split 13

set.seed(1)
bag.cars = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=100)
bag.cars


yhat.bag = predict(bag.cars, newdata = Cars[-train,])
plot(yhat.bag, cars.test)
abline(0,1)
mse = mean((yhat.bag-cars.test)^2)
rmse = sqrt(mse)
rmse ##7011.453


##BAGGING TREES = 200, #of variables tried at each split 13

set.seed(1)
bag.cars = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=200)
bag.cars


yhat.bag = predict(bag.cars, newdata = Cars[-train,])
plot(yhat.bag, cars.test)
abline(0,1)
mse = mean((yhat.bag-cars.test)^2)
rmse = sqrt(mse)
rmse #7008.191


#How to figure out which variables are important
names(bag.cars)
options(scipen=999)
importance(bag.cars)
varImpPlot(bag.cars)
#according to this plot the most important variables are
#Mileage, year, and trim


#checking the residuals vs. fitted
plot(yhat.bag,(yhat.bag-cars.test))#residual plot













