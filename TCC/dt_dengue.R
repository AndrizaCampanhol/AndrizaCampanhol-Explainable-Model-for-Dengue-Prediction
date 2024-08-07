require(rpart)
require(rpart.plot)
require(ggplot2)
require(dplyr)
require(caret)
require(pROC)

dataDengue <- read.csv("data/forecast.csv", check.names = FALSE)
dataClass <- read.csv("data/discretized_dataset_qSAX_2.csv", check.names = FALSE)
#dataClass <- read.csv("data/discretized_dataset_qSAX_5.csv", check.names = FALSE)

dataDengue <- dataDengue %>%
  mutate(
    `Chuva (mm)-1` = lag(`Chuva (mm)`, 1),
    `Chuva (mm)-2` = lag(`Chuva (mm)`, 2),
  )

dataDengue <- dataDengue %>%
  mutate(
    `Pressao Ins. (hPa)-1` = lag(`Pressao Ins. (hPa)`, 1),
    `Pressao Ins. (hPa)-2` = lag(`Pressao Ins. (hPa)`, 2)
  )

dataDengue <- dataDengue %>%
  mutate(
    `Pto Orvalho Ins. (C)-1` = lag(`Pto Orvalho Ins. (C)`, 1),
    `Pto Orvalho Ins. (C)-2` = lag(`Pto Orvalho Ins. (C)`, 2)
  )

dataDengue <- cbind(dataDengue, symbols = dataClass$Symbols)

colunas_desejadas <- c("Pto Orvalho Ins. (C)","Pto Orvalho Ins. (C)-1", "Pto Orvalho Ins. (C)-2", 
                       "Pressao Ins. (hPa)", "Pressao Ins. (hPa)-1", "Pressao Ins. (hPa)-2",
                       "Chuva (mm)", "Chuva (mm)-1","Chuva (mm)-2", "symbols")

#colunas_desejadas <- c("Pto Orvalho Ins. (C)", 
#                       "Pressao Ins. (hPa)",
#                       "Chuva (mm)", "symbols")

df <- dataDengue %>% select(all_of(colunas_desejadas))
df <- df[complete.cases(df), ]

df$symbols <- factor(df$symbols, levels = c(2,1))
#df$symbols <- factor(df$symbols, levels = c(5,4,3,2,1))

tree_model <- rpart(symbols ~ ., data = df, method = "class", control = list(maxdepth = 6))

rpart.plot(tree_model)


predictions <- predict(tree_model, df, type = "class")

conf_matrix <- confusionMatrix(predictions, df$symbols)
print(conf_matrix)
