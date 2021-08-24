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
``` r
library(wsDist)
(x <- rnorm(10))
#>  [1] -0.711231351  0.886870283  0.691697288  1.235822197 -0.009645704
#>  [6]  0.593354885 -0.531797156  0.180446488 -0.587031374 -1.212590241
(par <- fit(x, "nor", "mm"))
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------- 
#> mu = 0.0536
#> sigma = 0.7994
density_function(x, par)
#> Função densidade de probabilidade
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------------------------------- 
#>  [1] 0.3157742 0.2898703 0.3628922 0.1672002 0.4974708 0.3973150 0.3816755
#>  [8] 0.4927860 0.3619810 0.1423643
(p <- prob_function(x, par))
#> Função cumulativa de probabilidade
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> ---------------------------------- 
#>  [1] 0.16935929 0.85137190 0.78762195 0.93040751 0.46847663 0.75022007
#>  [7] 0.23200820 0.56304069 0.21146719 0.05661498
q_function(p, par)
#> Quantis
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------------------------------- 
#>  [1] -0.711231351  0.886870283  0.691697288  1.235822197 -0.009645704
#>  [6]  0.593354885 -0.531797156  0.180446488 -0.587031374 -1.212590241
plotting_position(x, formula = "blom")
#> Posição de plotagem
#> Fórmula: blom
#> ------------------- 
#>  [1] 0.06097561 0.15853659 0.25609756 0.35365854 0.45121951 0.54878049
#>  [7] 0.64634146 0.74390244 0.84146341 0.93902439
ad_test(x, par)
#> Teste de aderência: Anderson-Darling
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> ------------------------------------ 
#> statistic = 1.4981
#> p.value = 0.4440
chi_square_test(x, par)
#> Teste de aderência: Qui-quadrado
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> -------------------------------- 
#> statistic = 90.0000
#> p.value = 0.2313
filliben_test(x, par)
#> Teste de aderência: Filliben
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> ---------------------------- 
#> statistic = 0.9880
#> p.value = 0.9163
```

## Disponibilidade

Distribuições disponíveis para métodos e testes.

|      Distribuição       | Parâmetros MMO | Parâmetros ML | Parâmetros MML | Teste de Filliben |
|:-----------------------:|:-------------:|:--------------:|:---------------:|:-----------------:|
|          Gamma          |      ✅       |       ✅       |       ✅        |        ❌         |
|           GEV           |      ✅       |       ✅       |       ✅        |        ✅         |
| Logística generalizada  |      ❌       |       ✅       |       ✅        |        ✅         |
|   Normal generalizada   |      ❌       |       ❌       |       ✅        |        ❌         |
|   Pareto generalizada   |      ❌       |       ❌       |       ✅        |        ❌         |
|   Gumbel para mínimos   |      ✅       |       ❌       |       ✅        |        ❌         |
|   Gumbel para máximos   |      ✅       |       ✅       |       ✅        |        ❌         |
|          Kappa          |      ❌       |       ❌       |       ✅        |        ❌         |
| Log-normal 3 parâmetros |      ✅       |       ✅       |       ✅        |        ❌         |
|         Normal          |      ✅       |       ✅       |       ✅        |        ✅         |
|     Pearson tipo 3      |      ❌       |       ❌       |       ✅        |        ✅         |
|         Wakeby          |      ❌       |       ❌       |       ✅        |        ❌         |
|         Weibull         |      ✅       |       ✅       |       ✅        |        ✅         |
