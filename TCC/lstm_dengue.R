require(keras)
require(tensorflow)
require(dplyr)
require(forecast)
require(ggplot2)

dataDengue <- read.csv("data/dengue_inmet.csv", check.names = FALSE)

lag <- 12
prediction <- 12
normalization <- c(mean(dataDengue$Casos), sd(dataDengue$Casos))

scaledCases <- (dataDengue$Casos - normalization[1]) / normalization[2]
scaledCases <- matrix(scaledCases)

num_samples <- (nrow(scaledCases) - lag - prediction + 1)

train_X <- array(0, dim = c(num_samples, lag, 1))
train_Y <- array(0, dim = c(num_samples, prediction, 1))


for(i in 1:num_samples){
  train_X[i, ,1] <- scaledCases[i:(i + lag - 1), 1]
  train_Y[i, ,1] <- scaledCases[(i+lag):(i + lag + prediction - 1), 1]
}


lstm <- keras_model_sequential()

lstm %>%
  layer_lstm(units = 50, 
             batch_input_shape = c(1, lag, 1),
             return_sequences = TRUE) %>%
  layer_dropout(rate = 0.5) %>%
  layer_lstm(units = 50,
             return_sequences = TRUE) %>%
  layer_dropout(rate = 0.5) %>%
  time_distributed(layer_dense(units = 1))


lstm %>%
  compile(loss = 'mae', optimizer = 'adam', metrics = c('mae', 'mse'))


summary(lstm)

history <- fit(
  object = lstm,
  x = train_X,
  y = train_Y,
  epochs = 20,
  batch_size = 1
)


test_X <- tail(dataDengue$Casos, prediction)
test_X <- (test_X - normalization[1]) / normalization[2]

prediction_X <- array(data = test_X, dim = c(1, lag, 1))

lstm_forecast <- predict(lstm, prediction_X, batch_size = 1)[,,1]
lstm_forecast <- lstm_forecast * normalization[2] + normalization[1]


tsData <- ts(dataDengue$Casos, start = c(2010, 1), end = c(2023, 12), frequency = 12)
tsPrediction <- ts(lstm_forecast, start = c(2024, 1), end = c(2024, 12), frequency = 12)


forecast <- structure(list(
  mean = tsPrediction,
  x = tsData),
  class = "forecast")

autoplot(forecast) +  
  labs(x = "Tempo", y = "Casos de dengue", title = "Previsão com LSTM") +
  theme_minimal() +
  scale_color_manual(name = "Legenda de Cores",  
                     values = c("black", "blue"), 
                     labels = c("Time series", "Prediction"))


# write.csv() para salvar "lstm_forecast" em forecast.csv
