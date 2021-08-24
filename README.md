
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
##  [1] -0.8725546 -0.3054043 -0.4065029 -0.1156478 -0.1117916 -1.9835111
##  [7]  0.4737094  0.5489315  2.0950892  1.3627847
```

```r
(par <- fit(x, "nor", "mm"))
```

```
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------- 
## mu = 0.0685
## sigma = 1.1404
```

```r
density_function(x, par)
```

```
## Função densidade de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] 0.24887334 0.33150861 0.32074915 0.34528318 0.34546979 0.06931202
##  [7] 0.32841677 0.32011263 0.07213296 0.18372029
```

```r
(p <- prob_function(x, par))
```

```
## Função cumulativa de probabilidade
## Distribuição Normal
## Estimador de parâmetros: Momentos
## ---------------------------------- 
##  [1] 0.20463552 0.37150545 0.33851569 0.43585773 0.43718960 0.03598368
##  [7] 0.63881786 0.66321726 0.96221713 0.87178942
```

```r
q_function(p, par)
```

```
## Quantis
## Distribuição Normal
## Estimador de parâmetros: Momentos
## --------------------------------- 
##  [1] -0.8725546 -0.3054043 -0.4065029 -0.1156478 -0.1117916 -1.9835111
##  [7]  0.4737094  0.5489315  2.0950892  1.3627847
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
## statistic = 0.7885
## p.value = 0.8593
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
## statistic = 0.9761
## p.value = 0.6287
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
