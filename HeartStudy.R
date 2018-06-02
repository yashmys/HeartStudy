install.packages('caTools')
library('caTools')

install.packages('ROCR')
library('ROCR')

quality <- read.csv("quality.csv")
quality

str(quality)

table(quality$PoorCare)

set.seed(88)
split <-  sample.split(quality$PoorCare,SplitRatio = 0.75)

qualityTrain <-  subset(quality,split == TRUE)
qualityTest <-  subset(quality,split == FALSE )

nrow(qualityTest)
nrow(qualityTrain)


QualityLog <-  glm(qualityTrain$PoorCare ~ qualityTrain$OfficeVisits + qualityTrain$Narcotics, data = qualityTrain , family=binomial() )
summary(QualityLog)

predictTrain <- predict(QualityLog,type = "response")
summary(predictTrain)
tapply(predictTrain,qualityTrain$PoorCare,mean)

table(qualityTrain$PoorCare,predictTrain > 0.5)
table(qualityTrain$PoorCare,predictTrain > 0.7)
table(qualityTrain$PoorCare,predictTrain > 0.2)

ROCRpred <-  prediction(predictTrain,qualityTrain$PoorCare)
class(ROCRpred)
ROCRpred
ROCRperf <- performance(ROCRpred,"tpr","fpr")
class(ROCRperf)
ROCRperf
plot(ROCRperf,colorize =TRUE, print.cutoffs.at=seq(0,1,0.1),text.adj= c(-0.2,1.7))
