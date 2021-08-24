
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
##  [1]  0.5079935  1.2695309 -0.2433801  0.1205153  0.8030157 -0.8070466
##  [7]  1.5765171  0.6590530 -0.5986896  1.4827146
```

```r
(par <- fit(x, "nor", "mm"))
```

```
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------- 
## mu = 0.4770
## sigma = 0.8460
```

```r
density_function(x, par)
```

```
## Função densidade de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] 0.4712703 0.3040793 0.3281617 0.4315153 0.4378399 0.1490246 0.2026515
##  [8] 0.4607942 0.2101101 0.2326314
```

```r
(p <- prob_function(x, par))
```

```
## Função cumulativa de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ---------------------------------- 
##  [1] 0.51460230 0.82557381 0.19722317 0.33672275 0.65001240 0.06452145
##  [7] 0.90314866 0.58518528 0.10175941 0.88274479
```

```r
q_function(p, par)
```

```
## Quantis
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1]  0.5079935  1.2695309 -0.2433801  0.1205153  0.8030157 -0.8070466
##  [7]  1.5765171  0.6590530 -0.5986896  1.4827146
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
## statistic = 2.3682
## p.value = 0.1757
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
## statistic = 0.9867
## p.value = 0.8934
```
## Disponibilidade

Distribuições disponíveis para métodos e testes.

|      Distribuição       | Parâmetros MM | Parâmetros MMV | Parâmetros MML | Teste de Filliben |
|:-----------------------:|:-------------:|:--------------:|:--------------:|:-----------------:|
|          Gamma          |      ✅       |       ✅       |       ✅       |        ❌         |
|           GEV           |      ✅       |       ✅       |       ✅       |        ✅         |
| Logística generalizada  |      ❌       |       ✅       |       ✅       |        ✅         |
|   Normal generalizada   |      ❌       |       ❌       |       ✅       |        ❌         |
|   Pareto generalizada   |      ❌       |       ❌       |       ✅       |        ❌         |
|   Gumbel para mínimos   |      ✅       |       ❌       |       ✅       |        ❌         |
|   Gumbel para máximos   |      ✅       |       ✅       |       ✅       |        ❌         |
|          Kappa          |      ❌       |       ❌       |       ✅       |        ❌         |
| Log-normal 3 parâmetros |      ✅       |       ✅       |       ✅       |        ❌         |
|         Normal          |      ✅       |       ✅       |       ✅       |        ✅         |
|     Pearson tipo 3      |      ❌       |       ❌       |       ✅       |        ✅         |
|         Wakeby          |      ❌       |       ❌       |       ✅       |        ❌         |
|         Weibull         |      ✅       |       ✅       |       ✅       |        ✅         |
