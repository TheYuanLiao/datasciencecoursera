set.seed(3523)

library(AppliedPredictiveModeling)
library(e1071)
data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, 
                              p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(325)
mod <- svm(CompressiveStrength ~ ., data=training)
pred <- predict(mod, testing)
accuracy(pred, testing$CompressiveStrength)
