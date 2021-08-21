#' Função cumulativa de probabilidade
#'
#' @param x vetor numérico.
#' @param parameters parâmetros da distribuição.
#' @param exced logical; probabilidade de excedência.
#' @return Função cumulativa de probabilidade.
#' @examples
#' x <- rnorm(50)
#' par <- fit(x, "nor", "mm")
#' prob_function(x, par)
#' @export
prob_function <- function(x, parameters, exced = FALSE) {
  UseMethod("prob_function", parameters)
}

#' print method
#' @method print prob_function
#' @param x S3 object of class prob_function.
#' @export
print.prob_function <- function(x, ...) {
  method <- attr(x, "method")
  dist <- class(x)[2]

  s1 <- sprintf("Função cumulativa de probabilidade\n")
  cat(s1)
  cat(sprintf("Distribuição %s\n", crayon::yellow(.DIST_LIST[dist])))
  cat(sprintf("Método de ajuste: %s\n", crayon::yellow(.METHOD_LIST[method])))
  cat(paste0(rep("-", nchar(s1)-1), collapse = ""), "\n")
  print(as.numeric(x))
}

.prob_function_class <- function(d, par) {
  structure(
    d,
    class = c("prob_function", class(par)[2]),
    method = attr(par, "method")
  )
}

.p_funs_list <- list(
  gam     = pgamma,
  gev     = EnvStats::pgevd,
  glo     = glogis::pglogis,
  gno     = gnorm::pgnorm,
  gpa     = Pareto::pPareto,
  gum_min = function(x, xi, alpha) lmom::cdfgum(x, c(xi, alpha)),
  gum_max = function(x, xi, alpha) lmom::cdfgum(x, c(xi, alpha)),
  kap     = FAdist::pkappa4,
  ln3     = FAdist::plnorm3,
  nor     = pnorm,
  pe3     = PearsonDS::ppearsonIII,
  wak     = function(x, xi, alpha, beta, gamma, delta) lmomco::cdfwak(x, c(xi, alpha, beta, gamma, delta)),
  wei     = FAdist::pweibull3
)

.prob_fun <- function(dist) {
  p_fun <- .p_funs_list[[dist]]
  function(x, parameters, exced = FALSE) {
    par <- as.list(parameters)
    args <- list(q = x)
    args <- c(args, unname(par))

    p <- do.call(p_fun, args)

    if (exced)
      p <- 1 - p

    .prob_function_class(p, parameters)
  }
}

# gera os métodos
for (.dist in names(.d_funs_list)) {
  assign(sprintf("prob_function.%s", .dist), .prob_fun(.dist))
}

# testes
# library(wsDist)
# x <- rnorm(50)
# par <- wsDist::fit(x, "gev", "ml")
# wsDist::density_function(x, par)
# wsDist::prob_function(x, par, exced = TRUE)
