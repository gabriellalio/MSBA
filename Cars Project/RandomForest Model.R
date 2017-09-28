##RANDOM FOREST MODELS
Cars = read.csv("Cars.csv")
dim(Cars)
#bagging since we are using all the variables at every split
train = sample(1:nrow(Cars), nrow(Cars)/2)
cars.test = Cars[-train, "price"]

##Random forest trees= ?? did nto specify??, mtry=6
set.seed(1)
rf.cars = randomForest(price~., data=Cars, subset=train, mtry=6, imprtance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse##7503.239

importance(rf.cars)
varImpPlot(rf.cars)
##important variables are year, mileage
# condition, dispacement, trim


##Random forest trees= 100, mtry=3
set.seed(1)
rf.cars = randomForest(price~., data=Cars, subset=train, mtry=3, ntree=100, imprtance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse##7501.887

varImpPlot(rf.cars)
## year, mileage, condition, dispacement, trim

##Random forest trees= 200, mtry=3
set.seed(1)
rf.cars = randomForest(price~., data=Cars, subset=train, mtry=3, ntree=200, imprtance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse##7499.983

varImpPlot(rf.cars)
## year, mileage, condition, dispacement, trim

##Random forest trees= 100, mtry=10
set.seed(1)
rf.cars = randomForest(price~., data=Cars, subset=train, mtry=10, ntree=100, imprtance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse #7646.735

varImpPlot(rf.cars)

## Important data year, mileage, ?trim


##Random forest trees= 300, mtry=4
set.seed(1)
rf.cars = randomForest(price~., data=Cars, subset=train, mtry=4, ntree=300, imprtance=TRUE)
yhat.rf = predict(rf.cars, newdata = Cars[-train,])
mse = mean((yhat.rf - cars.test)^2)
rmse = sqrt(mse)
rmse ## 7456.136
varImpPlot(rf.cars)




