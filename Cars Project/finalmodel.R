library(randomForest)
##RANDOM FOREST MODELS
Cars = read.csv("Cars.csv")
train.Cars = Cars[1:29466,]
test.Cars = Cars[29467:39466,]

finalmodel = randomForest(train.Cars$price~., data=train.Cars, ntree = 200,  mtry=6, nodesize=20, importance=TRUE)
finalmodel

yhat.finalmodel = predict(finalmodel, newdata = test.Cars )

mse = mean((yhat.finalmodel - test.Cars['price'])^2)
rmse = sqrt(mse)
rmse
varImpPlot(finalmodel, col="gold")


