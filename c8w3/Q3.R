library(pgmm)
data(olive)
olive <- olive[,-1]
modFit <- train(Area ~ ., method='rpart', data=olive)
newdata <- as.data.frame(t(colMeans(olive)))
predict(modFit, newdata=newdata)
