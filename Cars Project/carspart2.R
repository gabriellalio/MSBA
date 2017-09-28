library(boot)
Cars = read.csv("Cars.csv")
attach(Cars)
names(Cars)
str(Cars)
str(region)
cv.error.10 = rep(0, 10)
for (i in 1:10) {
  glm.fit = glm(price ~ trim + condition + isOneOwner + mileage +year +  color + dispacement + fuel + region + soundSystem + wheelType + wheelSize + featureCount, data = Cars)
  cv.error.10[i] = cv.glm(Cars, glm.fit, K = 10)$delta[1] 
}
cv.error.10


