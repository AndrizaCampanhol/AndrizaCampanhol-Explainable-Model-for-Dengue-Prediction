# AndrizaCampanhol-Explainable-Model-for-Dengue-Prediction

## Objetivo geral

Este trabalho busca propor um modelo para resolver problemas de XAI na predição de dengue em modelos LSTM, utilizando dados temporais das condições climáticas* e casos de dengue** em Porto Alegre.

## Objetivos específicos
- Implementar um modelo preditivo utilizando uma rede neural LSTM*** para prever os casos de dengue referentes ao ano de 2024.
- Utilizar a técnica de SAX****, com variações, para classificar os dados temporais e preditos em símbolos, a fim de identificar os picos de casos e correlações com os dados climáticos, para duas e cinco classes.
- Aplicar o algoritmo de Random Forest para descobrir as variáveis mais influentes nas explosões de casos de dengue classificadas.
- Empregar árvores de decisão para criar representações explicativas dos resultados do modelo, baseadas nas características climáticas encontradas, buscando as de maior precisão.

---

*dados coletados da API do Instituto Nacional de Meteorologia [INMET](https://portal.inmet.gov.br/)

**dados coletados da API do [InfoDengue](https://info.dengue.mat.br/services/api)

***implementação do modelo LSTM foi baseada nesse [tutorial](http://datasideoflife.com/?p=1171)

****plataforma utilizada para discretização disponível em [Symbols!](https://esilveira.shinyapps.io/symbols/)
