#' Função quantil
#'
#' @param x vetor de probabilidades.
#' @param parameters parâmetros da distribuição.
#' @return Quantis.
#' @examples
#' x <- rnorm(50)
#' par <- fit(x, "nor", "mm")
#' q_function(x, par)
#' @export
q_function <- function(x, parameters) {
  UseMethod("q_function", parameters)
}

#' print method
#' @method print q_function
#' @param x S3 object of class q_function.
#' @export
print.q_function <- function(x, ...) {
  method <- attr(x, "method")
  dist <- class(x)[2]

  cat(sprintf("Quantis\n"))
  cat(sprintf("Distribuição %s\n", crayon::yellow(.DIST_LIST[dist])))
  s1 <- sprintf("Estimador de parâmetros: %s\n", crayon::yellow(.METHOD_LIST[method]))
  cat(s1)
  cat(paste0(rep("-", nchar(s1)-1), collapse = ""), "\n")
  print(as.numeric(x))
}

.q_function_class <- function(p, par) {
  structure(
    p,
    class = c("q_function", class(par)[2], "numeric"),
    method = attr(par, "method")
  )
}

.q_funs_list <- list(
  gam     = function(f, alpha, beta) lmom::quagam(f, c(alpha, beta)),
  gev     = function(f, xi, alpha, k) lmom::quagev(f, c(xi, alpha, k)),
  glo     = function(f, xi, alpha, k) lmom::quaglo(f, c(xi, alpha, k)),
  gno     = function(f, xi, alpha, k) lmom::quagno(f, c(xi, alpha, k)),
  gpa     = function(f, xi, alpha, k) lmom::quagpa(f, c(xi, alpha, k)),
  gum_min = function(f, xi, alpha) (log(-log(1 - f)) / alpha) + xi,
  gum_max = function(f, xi, alpha) lmom::quagum(f, c(xi, alpha)),
  kap     = function(f, xi, alpha, k, h) lmom::quakap(f, c(xi, alpha, k, h)),
  ln3     = function(f, zeta, mu, sigma) lmom::qualn3(f, c(zeta, mu, sigma)),
  nor     = function(f, mu, sigma) lmom::quanor(f, c(mu, sigma)),
  pe3     = function(f, mu, sigma, gamma) lmom::quape3(f, c(mu, sigma, gamma)),
  wak     = function(f, xi, alpha, beta, gamma, delta) lmom::quawak(f, c(xi, alpha, beta, gamma, delta)),
  wei     = function(f, zeta, beta, delta) lmom::quawei(f, c(zeta, beta, delta))
)

# .q_funs_list <- list(
#   gam     = qgamma,
#   gev     = EnvStats::qgevd,
#   glo     = glogis::qglogis,
#   gno     = gnorm::qgnorm,
#   gpa     = Pareto::qPareto,
#   gum_min = function(p, xi, alpha) lmom::quagum(p, c(xi, alpha)),
#   gum_max = function(p, xi, alpha) lmom::quagum(p, c(xi, alpha)),
#   kap     = FAdist::qkappa4,
#   ln3     = FAdist::qlnorm3,
#   nor     = qnorm,
#   pe3     = PearsonDS::qpearsonIII,
#   wak     = function(p, xi, alpha, beta, gamma, delta) lmomco::quawak(p, c(xi, alpha, beta, gamma, delta)),
#   wei     = FAdist::qweibull3
# )

.q_fun <- function(dist) {
  q_fun <- .q_funs_list[[dist]]

  function(f, parameters) {
    par <- as.list(parameters)
    args <- list(f)
    args <- c(args, unname(par))

    q <- do.call(q_fun, args)

    .q_function_class(q, parameters)
  }
}

# gera os métodos
for (.dist in names(.d_funs_list)) {
  assign(sprintf("q_function.%s", .dist), .q_fun(.dist))
}

