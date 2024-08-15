# AndrizaCampanhol-Explainable-Model-for-Dengue-Prediction

## Resumo

A dengue é um crescente problema de saúde no Brasil nos últimos anos, especialmente em regiões como Porto Alegre, onde sua incidência tem sido significativa (SMS-POA, 2024).
Caracterizada por um padrão sazonal e fortemente influenciada por fatores climáticos, a dengue apresenta desafios significativos no que diz respeito à previsão e controle de sua propagação (GOV-MS, 2024). Embora métodos de forecasting tenham sido amplamente
utilizados para predição da doença, a falta de explicabilidade desses modelos os torna menos claros sobre os fatores que podem influenciar suas previsões. Dessa forma, este
trabalho busca explicar a saída de modelos preditivos de valores contínuos, utilizando dados temporais relativos as condições climáticas e casos de dengue em Porto Alegre. O
objetivo é abordar problemas de Explicabilidade de Inteligência Artificial (XAI) em modelos Long Short-Term Memory (LSTM) para previsão, empregando técnicas de Symbolic Aggregate approXimation (SAX) e apresentando os resultados de forma explicável através de Árvores de Decisão.

## Objetivo geral

Este trabalho busca propor um modelo para resolver problemas de XAI na predição de dengue em modelos LSTM, utilizando dados temporais das condições climáticas e casos de dengue em Porto Alegre.

## Objetivos específicos
- Implementar um modelo preditivo utilizando uma rede neural LSTM para prever os casos de dengue referentes ao ano de 2024.
- Utilizar a técnica de SAX, com variações, para classificar os dados temporais e preditos em símbolos, a fim de identificar os picos de casos e correlações com os dados climáticos, para duas e cinco classes.
- Aplicar o algoritmo de Random Forest para descobrir as variáveis mais influentes nas explosões de casos de dengue classificadas.
- Empregar árvores de decisão para criar representações explicativas dos resultados do modelo, baseadas nas características climáticas encontradas, buscando as de maior precisão.

---

dados coletados da API do Instituto Nacional de Meteorologia [INMET](https://portal.inmet.gov.br/)

dados coletados da API do [InfoDengue](https://info.dengue.mat.br/services/api)

implementação do modelo LSTM foi baseada nesse [tutorial](http://datasideoflife.com/?p=1171)

plataforma utilizada para discretização disponível em [Symbols!](https://esilveira.shinyapps.io/symbols/)
