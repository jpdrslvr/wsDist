#' Função densidade de probabilidade
#'
#' @param x vetor numérico.
#' @param parameters parâmetros da distribuição.
#' @return Função densidade de probabilidade.
#' @examples
#' x <- rnorm(50)
#' par <- fit(x, "nor", "mm")
#' density_function(x, par)
#' @export
density_function <- function(x, parameters) {
  UseMethod("density_function", parameters)
}

#' print method
#' @method print density_function
#' @param x S3 object of class density_function.
#' @export
print.density_function <- function(x, ...) {
  method <- attr(x, "method")
  dist <- class(x)[2]

  s1 <- sprintf("Função densidade de probabilidade\n")
  cat(s1)
  cat(sprintf("Distribuição %s\n", crayon::yellow(.DIST_LIST[dist])))
  cat(sprintf("Estimador de parâmetros: %s\n", crayon::yellow(.METHOD_LIST[method])))
  cat(paste0(rep("-", nchar(s1)-1), collapse = ""), "\n")
  print(as.numeric(x))
}

.density_function_class <- function(d, par) {
  structure(
    d,
    class = c("density_function", class(par)[2], "numeric"),
    method = attr(par, "method")
  )
}

.d_funs_list <- list(
  gam     = dgamma,
  gev     = EnvStats::dgevd,
  glo     = glogis::dglogis,
  gno     = gnorm::dgnorm,
  gpa     = Pareto::dPareto,
  gum_min = function(x, xi, alpha) alpha * exp(alpha * (x - xi) - exp(alpha * (x - xi))),
  gum_max = function(x, xi, alpha) alpha * exp(-alpha * (x - xi) - exp(-alpha * (x - xi))),
  kap     = FAdist::dkappa4,
  ln3     = FAdist::dlnorm3,
  nor     = dnorm,
  pe3     = PearsonDS::dpearsonIII,
  wak     = function(x, xi, alpha, beta, gamma, delta) lmomco::pdfwak(x, c(xi, alpha, beta, gamma, delta)),
  wei     = FAdist::dweibull3
)

.density_fun <- function(dist) {
  d_fun <- .d_funs_list[[dist]]

  function(x, parameters) {
    par <- as.list(parameters)
    args <- list(x = x)
    args <- c(args, unname(par))

    d <- do.call(d_fun, args)

    .density_function_class(d, parameters)
  }
}

# gera os métodos e exporta para o namespace
file.create("R/exports.R")
for (.dist in names(.d_funs_list)) {
  assign(sprintf("density_function.%s", .dist), .density_fun(.dist))
  write(
    x = sprintf("#' @exportS3Method density_function %s\nNULL\n", .dist),
    file = "R/exports.R",
    append = TRUE
  )
  write(
    x = sprintf("#' @exportS3Method prob_function %s\nNULL\n", .dist),
    file = "R/exports.R",
    append = TRUE
  )
  write(
    x = sprintf("#' @exportS3Method q_function %s\nNULL\n", .dist),
    file = "R/exports.R",
    append = TRUE
  )
}
