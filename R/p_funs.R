#' Funçãode distribuição de probabilidade
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
  cat(sprintf("Estimador de parâmetros: %s\n", crayon::yellow(.METHOD_LIST[method])))
  cat(paste0(rep("-", nchar(s1)-1), collapse = ""), "\n")
  print(as.numeric(x))
}

.prob_function_class <- function(d, par) {
  structure(
    d,
    class = c("prob_function", class(par)[2], "numeric"),
    method = attr(par, "method")
  )
}

.p_funs_list <- list(
  gam     = function(x, alpha, beta) lmom::cdfgam(x, c(alpha, beta)),
  gev     = function(x, xi, alpha, k) lmom::cdfgev(x, c(xi, alpha, k)),
  glo     = function(x, xi, alpha, k) lmom::cdfglo(x, c(xi, alpha, k)),
  gno     = function(x, xi, alpha, k) lmom::cdfgno(x, c(xi, alpha, k)),
  gpa     = function(x, xi, alpha, k) lmom::cdfgpa(x, c(xi, alpha, k)),
  gum_min = function(x, xi, alpha) 1 - exp(-exp(alpha * (x - xi))),
  gum_max = function(x, xi, alpha) lmom::cdfgum(x, c(xi, alpha)),
  kap     = function(x, xi, alpha, k, h) lmom::cdfkap(x, c(xi, alpha, k, h)),
  ln3     = function(x, zeta, mu, sigma) lmom::cdfln3(x, c(zeta, mu, sigma)),
  nor     = function(x, mu, sigma) lmom::cdfnor(x, c(mu, sigma)),
  pe3     = function(x, mu, sigma, gamma) lmom::cdfpe3(x, c(mu, sigma, gamma)),
  wak     = function(x, xi, alpha, beta, gamma, delta) lmom::cdfwak(x, c(xi, alpha, beta, gamma, delta)),
  wei     = function(x, zeta, beta, delta) lmom::cdfwei(x, c(zeta, beta, delta))
)

.prob_fun <- function(dist) {
  p_fun <- .p_funs_list[[dist]]
  function(x, parameters, exced = FALSE) {
    par <- as.list(parameters)
    args <- list(x)
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
