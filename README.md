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
#>  [1] -0.48995521 -0.73522447 -0.01885098  1.09602932  0.39523491  0.58323658
#>  [7]  0.20571471 -0.07832218  0.68163105 -0.32908800
  par <- fit(x, "nor", "mm")
  density_function(x, par)
#> Função densidade de probabilidade
#> Distribuição Normal
#> Método de ajuste: Momentos
#> --------------------------------- 
#>  [1] 0.3866810 0.2207497 0.6756634 0.1672024 0.6282633 0.5108047 0.6934315
#>  [8] 0.6538396 0.4389385 0.5051553
  (p <- prob_function(x, par))
#> Função cumulativa de probabilidade
#> Distribuição Normal
#> Método de ajuste: Momentos
#> ---------------------------------- 
#>  [1] 0.13814560 0.06442172 0.39636010 0.95465359 0.67837802 0.78604119
#>  [7] 0.55207823 0.35679425 0.83279239 0.20992920
  q_function(p, par)
#> Quantis
#> Distribuição Normal
#> Método de ajuste: Momentos
#> ---------------- 
#>  [1] -0.48995521 -0.73522447 -0.01885098  1.09602932  0.39523491  0.58323658
#>  [7]  0.20571471 -0.07832218  0.68163105 -0.32908800
```
