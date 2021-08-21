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
  

## Instalação

``` r
# Instalando através do pacote devtools
devtools::install_github("jpdrslvr/wsDist")
```

## Exemplos
``` r
library(wsDist)
(x <- rnorm(10))
#>  [1] -0.1168197 -0.4988713  1.1511349  0.7453760  0.9208822  1.1384126
#>  [7]  0.1217607 -1.2346303  1.7365574  0.4498936
(par <- fit(x, "nor", "mm"))
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------- 
#> mu = 0.4414
#> sigma = 0.8880
density_function(x, par)
#> Função densidade de probabilidade
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------------------------------- 
#>  [1] 0.36872862 0.25647599 0.32642048 0.42370358 0.38832136 0.33014630
#>  [7] 0.42109735 0.07567001 0.15507029 0.44925667
(p <- prob_function(x, par))
#> Função cumulativa de probabilidade
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> ---------------------------------- 
#>  [1] 0.26479999 0.14482895 0.78794677 0.63396126 0.70540608 0.78377025
#>  [7] 0.35944808 0.02954903 0.92766285 0.50382957
q_function(p, par)
#> Quantis
#> Distribuição Normal
#> Estimador de parâmetros: Momentos
#> --------------------------------- 
#>  [1] -0.1168197 -0.4988713  1.1511349  0.7453760  0.9208822  1.1384126
#>  [7]  0.1217607 -1.2346303  1.7365574  0.4498936
plotting_position(x, formula = "blom")
#> Posição de plotagem
#> Fórmula: blom
#> ------------------- 
#>  [1] 0.06097561 0.15853659 0.25609756 0.35365854 0.45121951 0.54878049
#>  [7] 0.64634146 0.74390244 0.84146341 0.93902439
```
