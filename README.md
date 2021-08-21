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
# Ajustando a distribuição normal pelo método da verossimilhança
x <- rnorm(50)
par <- fit(x, "nor", "ml")
density_function(x, par)
#> Função densidade de probabilidade
#> Distribuição Normal
#> Método de ajuste: Máxima Verossimilhança
#> --------------------------------- 
#>  [1] 0.29485742 0.39350063 0.07892538 0.39971221 0.26806750 0.34690866
#>  [7] 0.32093297 0.01702536 0.36509397 0.07790035 0.03287805 0.12073134
#> [13] 0.36317417 0.23607973 0.29436305 0.20298894 0.25801304 0.05883694
#> [19] 0.26713012 0.37851200 0.39879689 0.35849096 0.08398630 0.36547458
#> [25] 0.29082468 0.23654191 0.37802550 0.34768545 0.12223790 0.39699987
#> [31] 0.20416126 0.28070547 0.34760258 0.30903009 0.39931009 0.38766657
#> [37] 0.38175548 0.16668823 0.39549591 0.24544034 0.30130205 0.39706791
#> [43] 0.28931563 0.22397533 0.38533708 0.23122584 0.38555818 0.35172314
#> [49] 0.37209438 0.26246462
prob_function(x, par)
#> Função cumulativa de probabilidade
#> Distribuição Normal
#> Método de ajuste: Máxima Verossimilhança
#> ---------------------------------- 
#>  [1] 0.217614667 0.570597417 0.035825080 0.507163232 0.185646221 0.297146713
#>  [7] 0.253718776 0.005994806 0.664957423 0.964741635 0.012701505 0.939125538
#> [13] 0.330609171 0.847645698 0.783016720 0.122158658 0.825321567 0.025137367
#> [19] 0.184602228 0.629538209 0.472075195 0.320282044 0.961343583 0.664063332
#> [25] 0.212514008 0.847195928 0.369001994 0.701392136 0.938151472 0.453006659
#> [31] 0.876834381 0.799812565 0.701548575 0.236505202 0.519272250 0.402054072
#> [37] 0.619332934 0.092965922 0.441670547 0.838369170 0.773990782 0.546414632
#> [43] 0.210633925 0.859136522 0.393100400 0.147680556 0.606082966 0.693601985
#> [49] 0.647595326 0.820527283
```
