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
x <- rnorm(50)
par <- fit(x, "nor", "ml")
density_function(x, par)
#> Função densidade de probabilidade
#> Distribuição Normal
#> Método de ajuste: Máxima Verossimilhança
#> --------------------------------- 
#>  [1] 0.34909108 0.33534270 0.34897388 0.08783976 0.09789362 0.31794917
#>  [7] 0.26650414 0.13770527 0.34759981 0.34016467 0.34576002 0.28739082
#> [13] 0.16816704 0.32368716 0.26688888 0.34287058 0.19372752 0.17565066
#> [19] 0.34842245 0.34704046 0.17802145 0.32992012 0.04482839 0.31647062
#> [25] 0.09341691 0.30525373 0.11294426 0.15641093 0.12499147 0.01254766
#> [31] 0.26515752 0.34293039 0.33336597 0.21225686 0.34155366 0.24075974
#> [37] 0.24758419 0.34634234 0.08880424 0.23495046 0.23668020 0.34027350
#> [43] 0.07354077 0.12163110 0.22656394 0.31041577 0.33576308 0.34246567
#> [49] 0.33415406 0.17969191
(p <- prob_function(x, par))
#> Função cumulativa de probabilidade
#> Distribuição Normal
#> Método de ajuste: Máxima Verossimilhança
#> ---------------------------------- 
#>  [1] 0.52514764 0.38575094 0.52718416 0.04821502 0.94474391 0.66889970
#>  [7] 0.76958231 0.08605816 0.54458257 0.40664335 0.56047212 0.26537420
#> [13] 0.88691040 0.34685918 0.23101349 0.42080055 0.13850111 0.12025091
#> [19] 0.46478263 0.54995429 0.87743402 0.63381318 0.02132828 0.32728632
#> [25] 0.94791461 0.69912276 0.06634037 0.89773097 0.07569676 0.99505770
#> [31] 0.22834468 0.42114264 0.62175796 0.84122978 0.41361556 0.80629337
#> [37] 0.79711208 0.55593609 0.95112196 0.18616175 0.81161658 0.40717041
#> [43] 0.03869297 0.07304264 0.17567296 0.68746990 0.61258566 0.41852290
#> [49] 0.61882293 0.87578907
q_function(p, par)
#> Quantis
#> Distribuição Normal
#> Método de ajuste: Máxima Verossimilhança
#> ------------------------------ 
#>  [1] 0.52514764 0.38575094 0.52718416 0.04821502 0.94474391 0.66889970
#>  [7] 0.76958231 0.08605816 0.54458257 0.40664335 0.56047212 0.26537420
#> [13] 0.88691040 0.34685918 0.23101349 0.42080055 0.13850111 0.12025091
#> [19] 0.46478263 0.54995429 0.87743402 0.63381318 0.02132828 0.32728632
#> [25] 0.94791461 0.69912276 0.06634037 0.89773097 0.07569676 0.99505770
#> [31] 0.22834468 0.42114264 0.62175796 0.84122978 0.41361556 0.80629337
#> [37] 0.79711208 0.55593609 0.95112196 0.18616175 0.81161658 0.40717041
#> [43] 0.03869297 0.07304264 0.17567296 0.68746990 0.61258566 0.41852290
#> [49] 0.61882293 0.87578907
```
