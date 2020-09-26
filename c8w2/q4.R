library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

training2 <- training[, startsWith(colnames(training), 'IL')]
preProc <- preProcess(training2, method='pca', thresh = 0.9)
training2PC <- predict(preProc, training2)
