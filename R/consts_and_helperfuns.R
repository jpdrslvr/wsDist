quiet <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

.DIST_LIST <- c(
  exp     = "Exponencial",
  gam     = "Gamma",
  gev     = "GEV",
  glo     = "Logística generalizada",
  gno     = "Normal generalizada",
  gpa     = "Pareto generalizada",
  gum_min = "Gumbel para mínimos",
  gum_max = "Gumbel para máximos",
  kap     = "Kappa",
  ln3     = "Log-normal 3 parâmetros",
  nor     = "Normal",
  pe3     = "Pearson tipo 3",
  wak     = "Wakeby",
  wei     = "Weibull"
)

.METHOD_LIST <- c(
  mm = "Momentos",
  mml = "Momentos-L",
  ml = "Máxima Verossimilhança"
)

.params_dist <- function() {
  c(
    "@param dist distribuição de probabilidade.",
    "\\itemize{",
    unlist(
      lapply(
        names(.DIST_LIST),
        function(d) {
          sprintf("    \\item \"%s\" (%s)", d, .DIST_LIST[d])
        }
      )
    ),
    "}"
  )
}

.params_method <- function() {
  c(
    "@param method Método de ajuste.",
    "\\itemize{",
    unlist(
      lapply(
        names(.METHOD_LIST),
        function(m) {
          sprintf("    \\item \"%s\" (%s)", m, .METHOD_LIST[m])
        }
      )
    ),
    "}"
  )
}

.get_parameters_names <- function(dist) {
  switch(dist,
         # exp     = "rate",
         gam     = c("alpha", "beta"),
         gev     = c("xi", "alpha", "k"),
         glo     = c("xi", "alpha", "k"),
         gno     = c("xi", "alpha", "k"),
         gpa     = c("xi", "alpha", "k"),
         gum_min = c("xi", "alpha"),
         gum_max = c("xi", "alpha"),
         kap     = c("xi", "alpha", "k", "h"),
         ln3     = c("zeta", "mu", "sigma"),
         nor     = c("mu", "sigma"),
         pe3     = c("mu", "sigma", "gamma"),
         wak     = c("xi", "alpha", "beta", "gamma", "delta"),
         wei     = c("zeta", "beta", "delta")
  )
}
