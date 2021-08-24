
# wsDist

## Descrição

Ajuste de distribuições de probabilidade pelos métodos dos Momentos (mmo), Momentos-L (mml) e Máxima verossimilhança (ml).
Distribuições disponíveis:

  - Gamma (gam)
  - GEV (gev)
  - Logística generalizada (glo)
  - Normal generalizada (gno)
  - Pareto generalizada (gpa)
  - Gumbel para mínimos (gum_min)
  - Gumbel para máximos (gum_max)
  - Kappa (kap)
  - Log-normal 3 parâmetros (ln3)
  - Normal (nor)
  - Pearson tipo 3 (pt3)
  - Wakeby (wak)
  - Weibull (wei)
  
## Funções
  - `fit(x, dist, method)`: ajusta os parâmetros de *x* para a distribuição *dist*, pelo método *method*. 
  - `density_function(x, parameters)`: retorna a função densidade de probabilidade.
  - `prob_function(x, parameters, exced = FALSE)`: retorna a função cumulativa de probabilidade.
  - `plotting_position(x, formula, exced = FALSE)`: retorna as posições de plotagem. `formula` pode ser `"weibull"`, `"gringorten"`, `"blom"`, `"hazem"` ou `"cunnane"`.


## Testes de aderência
 - `ad_test`: Teste de Anderson-darling.
 - `chi_square_test`: Teste de Qui-quadrado
 - `ks_test`: Teste de Kolmogorov–Smirnov
 - `filliben_test`: Teste de Filliben
  

## Instalação

``` r
# Instalando através do pacote devtools
devtools::install_github("jpdrslvr/wsDist")
```

## Exemplos

```r
library(wsDist)
(x <- rnorm(10))
```

```
##  [1] -0.37316235  0.67402187  0.53896975 -1.52203786  0.48653701 -0.81129397
##  [7] -0.04176941 -0.14835219  1.33769987  0.79587793
```

```r
(par <- fit(x, "nor", "mm"))
```

```
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------- 
## mu = 0.0936
## sigma = 0.8469
```

```r
density_function(x, par)
```

```
## Função densidade de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] 0.40468760 0.37248833 0.41025627 0.07632988 0.42302161 0.26615995
##  [7] 0.46510217 0.45223936 0.16013644 0.33403300
```

```r
(p <- prob_function(x, par))
```

```
## Função cumulativa de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ---------------------------------- 
##  [1] 0.29073824 0.75343123 0.70050455 0.02820422 0.67865376 0.14262669
##  [7] 0.43647698 0.38752920 0.92908689 0.79650990
```

```r
q_function(p, par)
```

```
## Quantis
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] -0.37316235  0.67402187  0.53896975 -1.52203786  0.48653701 -0.81129397
##  [7] -0.04176941 -0.14835219  1.33769987  0.79587793
```

```r
plotting_position(x, formula = "blom")
```

```
## Posição de plotagem
## Fórmula: blom
## ------------------- 
##  [1] 0.06097561 0.15853659 0.25609756 0.35365854 0.45121951 0.54878049
##  [7] 0.64634146 0.74390244 0.84146341 0.93902439
```

```r
ad_test(x, par)
```

```
## Teste de aderência: Anderson-Darling
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ------------------------------------ 
## statistic = 1.9114
## p.value = 0.2871
```

```r
chi_square_test(x, par)
```

```
## Teste de aderência: Qui-quadrado
## Distribuição Normal
## Estimador de parâmetros: Momentos
## -------------------------------- 
## statistic = 90.0000
## p.value = 0.2313
```

```r
filliben_test(x, par)
```

```
## Teste de aderência: Filliben
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ---------------------------- 
## statistic = 0.9806
## p.value = 0.7401
```
## Disponibilidade

Distribuições disponíveis para métodos e testes.

|      Distribuição       | Parâmetros MM | Parâmetros MMV | Parâmetros MML | Teste de Filliben | Teste de Anderson-Darling | Teste de Qui-quadrado | Teste de Kolmogorov-Smirnov |
|:-----------------------:|:-------------:|:--------------:|:--------------:|:-----------------:|:-------------------------:|:---------------------:|:---------------------------:|
|          Gamma          |      ✅       |       ✅       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|           GEV           |      ✅       |       ✅       |       ✅       |        ✅         |            ✅             |          ✅           |             ✅              |
| Logística generalizada  |      ❌       |       ✅       |       ✅       |        ✅         |            ✅             |          ✅           |             ✅              |
|   Normal generalizada   |      ❌       |       ❌       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|   Pareto generalizada   |      ❌       |       ❌       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|   Gumbel para mínimos   |      ✅       |       ❌       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|   Gumbel para máximos   |      ✅       |       ✅       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|          Kappa          |      ❌       |       ❌       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
| Log-normal 3 parâmetros |      ✅       |       ✅       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|         Normal          |      ✅       |       ✅       |       ✅       |        ✅         |            ✅             |          ✅           |             ✅              |
|     Pearson tipo 3      |      ❌       |       ❌       |       ✅       |        ✅         |            ✅             |          ✅           |             ✅              |
|         Wakeby          |      ❌       |       ❌       |       ✅       |        ❌         |            ✅             |          ✅           |             ✅              |
|         Weibull         |      ✅       |       ✅       |       ✅       |        ✅         |            ✅             |          ✅           |             ✅              |
