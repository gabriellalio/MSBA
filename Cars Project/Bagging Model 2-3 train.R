library(randomForest)

Cars = read.csv("Cars.csv")
dim(Cars)
#bagging since we are using all the variables at every split (70%, 30%)
train = sample(1:nrow(Cars), 19644)
cars.test = Cars[-train, "price"]

#### BAGGING, TREES=100, #of variables tried at each split 13
set.seed(1)
bag.cars100 = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=100)
bag.cars100


yhat.bag100 = predict(bag.cars100, newdata = Cars[-train,])
plot(yhat.bag100, cars.test)
abline(0,1)
mse = mean((yhat.bag100-cars.test)^2)
rmse = sqrt(mse)
rmse #6850.194

varImpPlot(bag.cars100)

##BAGGING TREES = 200, #of variables tried at each split 13

set.seed(1)
bag.cars200 = randomForest(price~., data=Cars, subset=train, mtry=13, ntree=200)
bag.cars200


yhat.bag200 = predict(bag.cars200, newdata = Cars[-train,])
plot(yhat.bag200, cars.test)
abline(0,1)
mse = mean((yhat.bag200-cars.test)^2)
rmse = sqrt(mse)
rmse #6841.293

varImpPlot(bag.cars200)
# important predictors year, mileage, trim



##BAGGING TREES = 200, #of variables tried at each split 3

set.seed(1)
bag.cars200n3 = randomForest(price~ year + mileage + trim, data=Cars, subset=train, mtry=3, ntree=200)
bag.cars200n3


yhat.bag200n3 = predict(bag.cars200n3, newdata = Cars[-train,])
plot(yhat.bag200n3, cars.test)
abline(0,1)
mse = mean((yhat.bag200n3-cars.test)^2)
rmse = sqrt(mse)
rmse #8514.253

varImpPlot(bag.cars200n3)
# important predictors year, mileage, trim
