

##BOOSTING EXAMPLE
library(gbm)

Cars = read.csv("Cars.csv")
nrow(Cars)
train = sample(1:nrow(Cars), 19644 )#19644 is 2/3
cars.test = Cars[-train, "price"]


#used trees at 5000
set.seed(1)
boost.cars = gbm(price~., data=Cars[train,], distribution="gaussian", n.trees = 5000, interaction.depth=4)
summary(boost.cars)

#variabale importance
#year, mileage, trim, dispacement

par(mfrow=c(2,2))
plot(boost.cars, i="year")
plot(boost.cars, i="mileage")
plot(boost.cars, i="trim")
plot(boost.cars, i="dispacement")

yhat.boost = predict(boost.cars, newdata = Cars[-train,], n.trees=5000)
mse = mean((yhat.boost - cars.test)^2)
rmse = sqrt(mse)
rmse #7384.186



###Trying with trees as 5,000, depth = 6
set.seed(1)
boost.cars = gbm(price~., data=Cars[train,], distribution="gaussian", n.trees = 5000, interaction.depth=6)
yhat.boost = predict(boost.cars, newdata = Cars[-train,], n.trees=5000)
mse = mean((yhat.boost - cars.test)^2)
rmse = sqrt(mse)
rmse #7199.736

###Trying with trees as 5,000, depth = 10
set.seed(1)
boost.cars = gbm(price~., data=Cars[train,], distribution="gaussian", n.trees = 5000, interaction.depth=10)
yhat.boost = predict(boost.cars, newdata = Cars[-train,], n.trees=5000)
mse = mean((yhat.boost - cars.test)^2)
rmse = sqrt(mse)
rmse #6928.823


##IDK what this is doing but using the shrinkage made it worse### (example taken from back of book)

boost.cars = gbm(price~., data=Cars[train,], distribution="gaussian", n.trees = 5000, interaction.depth=10, shrinkage = .001, verbose=F)
yhat.boost = predict(boost.cars, newdata = Cars[-train,], n.trees = 5000)
mse = mean((yhat.boost - cars.test)^2)
rmse = sqrt(mse)
rmse ###7185.025

summary(boost.cars)
