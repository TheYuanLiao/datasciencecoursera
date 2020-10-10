library(caret)

library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]

set.seed(62433)
mod1 <- train(diagnosis ~ ., method='rf', data=training)
mod2 <- train(diagnosis ~ ., method='gbm', data=training)
mod3 <- train(diagnosis ~ ., method='lda', data=training)
pred1 <- predict(mod1, testing)
confusionMatrix(pred1, testing$diagnosis)$overall['Accuracy']

pred2 <- predict(mod2, testing)
confusionMatrix(pred2, testing$diagnosis)$overall['Accuracy']

pred3 <- predict(mod3, testing)
confusionMatrix(pred3, testing$diagnosis)$overall['Accuracy']

predDF <- data.frame(pred1, pred2, pred3, diagnosis=testing$diagnosis)
combModFit <- train(diagnosis ~ ., method="rf", data=predDF)
combPred <- predict(combModFit, predDF)
confusionMatrix(combPred, testing$diagnosis)$overall['Accuracy']
