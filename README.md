
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
##  [1]  0.1965886  0.4210939  0.5955979  1.0071905 -2.0071161  1.4405120
##  [7]  0.3590942 -1.2274356 -0.1200807 -1.3646927
```

```r
(par <- fit(x, "nor", "mm"))
```

```
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------- 
## mu = -0.0699
## sigma = 1.1132
```

```r
density_function(x, par)
```

```
## Função densidade de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] 0.34826037 0.32516272 0.29973214 0.22440895 0.07883534 0.14274209
##  [7] 0.33273377 0.20871677 0.35802266 0.18221006
```

```r
(p <- prob_function(x, par))
```

```
## Função cumulativa de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ---------------------------------- 
##  [1] 0.59461002 0.67043052 0.72503547 0.83338215 0.04090681 0.91259153
##  [7] 0.65003145 0.14920722 0.48203091 0.12238569
```

```r
q_function(p, par)
```

```
## Quantis
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1]  0.1965886  0.4210939  0.5955979  1.0071905 -2.0071161  1.4405120
##  [7]  0.3590942 -1.2274356 -0.1200807 -1.3646927
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
## statistic = 0.7988
## p.value = 0.8502
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
## statistic = 0.9689
## p.value = 0.4702
```
## Disponibilidade

Distribuições disponíveis para métodos e testes.
<table class="table table-striped table-hover table-bordered" style="margin-left: auto; margin-right: auto;">
 <thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1"></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Parâmetros</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="4"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Testes</div></th>
</tr>
  <tr>
   <th style="text-align:center;">   </th>
   <th style="text-align:center;"> MM </th>
   <th style="text-align:center;"> MMV </th>
   <th style="text-align:center;"> MML </th>
   <th style="text-align:center;"> Filliben </th>
   <th style="text-align:center;"> Anderson-Darling </th>
   <th style="text-align:center;"> Qui-quadrado </th>
   <th style="text-align:center;"> Kolmogorov-Smirnov </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Gamma </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> GEV </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Logística generalizada </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Normal generalizada </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Pareto generalizada </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Gumbel para mínimos </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Gumbel para máximos </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Kappa </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Log-normal 3 parâmetros </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Normal </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Pearson tipo 3 </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Wakeby </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ❌ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
  <tr>
   <td style="text-align:center;font-weight: bold;"> Weibull </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
   <td style="text-align:center;"> ✅ </td>
  </tr>
</tbody>
</table>
