#tunes mtry and ntree for random forest from randomForest package. 
#mtrys: vector of mtry values
#ntrees: vector of ntree values
#train: training data
#outcome: outcome variable
#p: fraction for validation set
#seed: set seed for rf

tuneRF <- function(mtrys, ntrees, train, outcome, p, seed){
library(caret)  
library(randomForest)
set.seed(seed)
inTrain <- createDataPartition(y = train$outcome, p = p, list = FALSE)
trainSub <- trainMod[inTrain, ]
testSub <- trainMod[-inTrain, ]
cErr <- data.frame(matrix(0, length(mtrys), length(ntrees)))
for (i in 1:length(mtrys)){
  for (j in 1:length(ntrees)){
    modRF <- randomForest(outcome ~ ., data = trainSub, ntree = ntrees[j], mtry = mtrys[i])
    predRF <- predict(modRF, testSub, type = c("class"))
    cErr[i,j] <- sum(testSub$outcome == predRF)/length(testSub$outcome)
  }
}
}

## plot accuracy
library(ggplot2)
library(reshape)
temp <- cErr
colnames(temp) <- ntrees
temp$mtry <- mtrys
data <- melt(temp, id = "mtry")
data$mtry <- factor(data$mtry)
data$variable <- as.numeric(data$variable)
ggplot(data, aes(x=variable, y=value, color = mtry)) + geom_line() + xlab("ntrees") + ylab("Accuracy")+
  ggtitle("Tune RF: mtry and ntree")