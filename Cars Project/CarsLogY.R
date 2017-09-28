

library(Metrics)
logCars = read.csv("logprice.csv")
attach(logCars)


dim(logCars)
fix(logCars)
names(logCars)
set.seed(4)
train = sample(1:29466, (29466/2))
test = (-train)

Cars.train = logCars[train,]
Cars.test = logCars[test,]

lm.logprice = lm(logprice~. , data= Cars.train)
summary(lm.logprice)
plot(lm.logprice, col="burlywood")
fittest = fitted(lm.logprice, data=Cars.test)
error = rmse(Cars.test$price, fittest)

test2 = (10^ (Cars.test$price))
fittest2 = (10^fittest)
error2 = rmse(gaby, fittest2)
error2

##error = 62,169.08
