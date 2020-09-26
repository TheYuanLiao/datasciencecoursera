library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

training2 <- training[, startsWith(colnames(training), 'IL')]
training2$diagnosis <- training$diagnosis

testing2 <- testing[, startsWith(colnames(training), 'IL')]
testing2$diagnosis <- testing$diagnosis

# non-PCA
model <- train(diagnosis ~ ., data = training2, method = "glm")
predict_model <- predict(model, newdata= testing2)
matrix_model <- confusionMatrix(predict_model, testing2$diagnosis)
print(matrix_model$overall[1])

# PCA
modelPCA <- train(diagnosis ~., data = training2, method = "glm", 
                  preProcess = "pca",
                  trControl=trainControl(preProcOptions=list(thresh=0.8)))
matrix_modelPCA <- confusionMatrix(testing2$diagnosis, predict(modelPCA, testing2))
print(matrix_modelPCA$overall[1])

