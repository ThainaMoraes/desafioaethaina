# 🚀 Lighthouse | Jornada Técnica - Analytics Engineering 🚀

## 📋 Certificação 

O objetivo desta certificação é avaliar suas competências em um projeto prático de Engenharia de Analytics conforme a metodologia do Modern Analytics Stack, desenvolvida pela Indicium mas que guarda muitas semelhanças com o Modern Data Stack utilizado por milhares de times de dados modernos.

A obtenção desta certificação indica que você:

- Entende o processo de construção de uma plataforma de analytics moderna;

- Entende os objetivos da modelagem dimensional em data warehouses modernos;

- Sabe aplicar a linguagem SQL e a ferramenta dbt para modelar dados em data warehouses modernos;

- Conhece as boas práticas de visualização de dados e sua aplicação em uma ferramenta de Self-Service BI.

## Resources:
A empresa contratou Adventure Works (AW) é uma indústria de bicicletas em franco crescimento que se orgulha de possuir mais de 500 produtos distintos, 20.000 clientes e 31.000 pedidos. Para manter seu ritmo de crescimento e se diferenciar da concorrência, a Adventure Works quer utilizar seus dados de forma estratégica, norteando suas decisões para se tornar uma empresa data driven. A diretoria da Adventure Works já listou uma série de perguntas que ela quer responder através de cruzamentos dos dados, e que devem guiar o desenvolvimento das tabelas de fatos e dimensões do data warehouse. Para iniciar o projeto e obter resultados rápidos, a opção foi iniciar pela área de vendas (sales), mas algumas tabelas de outras áreas podem ser necessárias para conseguir as informações desejadas. Em seu diagnóstico inicial, você identificou alguns sistemas que a Adventure Works utiliza e que geram dados relevantes para o negócio e que, em algum momento, devem fazer parte da infraestrutura de dados.

### Perguntas para serem respondidas:
- a) Qual o número de pedidos, quantidade comprada, valor total negociado por produto, tipo de cartão, motivo de venda, data de venda, cliente, status, cidade, estado e país?
- b) Quais os produtos com maior ticket médio por mês, ano, cidade, estado e país? (ticket médio = Faturamento bruto - descontos do produto / número de pedidos no período de análise)
- c) Quais os 10 melhores clientes por valor total negociado filtrado por produto, tipo de cartão, motivo de venda, data de venda, status, cidade, estado e país?
- d) Quais as 5 melhores cidades em valor total negociado por produto, tipo de cartão, motivo de venda, data de venda, cliente, status, cidade, estado e país?
- e) Qual o número de pedidos, quantidade comprada, valor total negociado por mês e ano (dica: gráfico de série de tempo)?
- f) Qual produto tem a maior quantidade de unidades compradas para o motivo de venda “Promotion”?

## 📝 Descrição dos dados:
A Adventure Works possui um banco de dados transacional (PostgreSQL) que armazena os dados de suas diferentes áreas. Esses dados estão distribuídos em 68 tabelas divididas em 5 schemas: HR (recursos humanos), sales (vendas), production (produção) e purchasing (compras). O diagrama se encontra disponível neste link: [Repositório Público](https://github.com/dpavancini/analytics-engineering/blob/main/AdventureWorks/AdventureWorksERD.jpeg) e [diagrama completo](https://github.com/dpavancini/analytics-engineering/blob/main/AdventureWorks/AdventureWorksERD.jpeg).

## 📊 Entregas:

- Diagrama conceitual do data warehouse: Modelo conceitual com as tabelas de fatos e dimensões necessárias para responder às perguntas de negócio.
- Data warehouse na nuvem: Google BigQuery
- Configuração e transformações de dados: DBT.
- Documentação das tabelas e colunas nos marts
- Testes de sources
- Testes nas primary keys das tabelas de dimensão e fatos
- Teste de dados
- O código precisa estar em um repositório (github).
- Painéis de BI: Responder as perguntas feitas anteriormente.

## 🛠 BI desenvolvido:
[Acesse o painél do BI por aqui.](https://app.powerbi.com/view?r=eyJrIjoiNDQyNWFmZWItZWViZi00ZmE2LTkwMzYtZmUwYTdiMTIzMjg1IiwidCI6ImZkYTI0OTdiLWIzOGItNDAyMy04NmJkLWFmOWQ4Y2ViMzk4NSJ9)
