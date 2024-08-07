require(caret)
require(randomForest)
require(dplyr)
require(magrittr)

dataDengue <- read.csv("data/forecast.csv", check.names = FALSE)
dataClass <- read.csv("data/discretized_dataset_qSAX_2.csv", check.names = FALSE)
#dataClass <- read.csv("data/discretized_dataset_qSAX_5.csv", check.names = FALSE)


dataDengue <- cbind(dataDengue, symbols = dataClass$Symbols)

colunas_desejadas <- c("Temp. Ins. (C)", "Umi. Ins. (%)","Pto Orvalho Ins. (C)",
                       "Pressao Ins. (hPa)", "Vel. Vento (m/s)", "Dir. Vento (m/s)",
                       "Raj. Vento (m/s)", "Chuva (mm)", "symbols")

df <- dataDengue %>% select(all_of(colunas_desejadas))
df <- df[complete.cases(df), ]

df$symbols <- factor(df$symbols, levels = c(1,2))
#df$symbols <- factor(df$symbols, levels = c(1,2,3,4,5))

ind <- createDataPartition(df$symbols, p=0.8, times=1, list=F)

treino <- df[ind,]
teste <- df[-ind,]

prop.table(table(treino$symbols))

randomForest <- randomForest(x = treino[,-9],
                   y = treino$symbols,
                   xtest = teste[,-9],
                   ytest = teste$symbols,
                   ntree = 500,
                   mtry = 8,
                   replace = T,
                   nodesize = 10,
                   maxnodes = 15,
                   keep.forest = T)

varImpPlot(randomForest)
