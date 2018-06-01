install.packages('caTools')
library('caTools')



quality <- read.csv("quality.csv")
quality

str(quality)

table(quality$PoorCare)

set.seed(88)
split <-  sample.split()

??sample.s