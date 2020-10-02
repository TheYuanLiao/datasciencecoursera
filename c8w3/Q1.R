library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)

training <- segmentationOriginal[segmentationOriginal$Case=='Train',]
test <- segmentationOriginal[segmentationOriginal$Case=='Test',]
set.seed(125)
modFit <- train(Class ~ ., method='rpart', data=training)
print(modFit$finalModel)
fancyRpartPlot(modFit$finalModel)
plot(modFit$finalModel, uniform=TRUE)
text(modFit$finalModel, use.n = TRUE, all=TRUE, cex=.8)
