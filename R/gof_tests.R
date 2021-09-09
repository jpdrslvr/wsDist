#' Teste de Anderson-Darling
#'
#' @param x vetor numérico
#' @param parameters parâmetros da distribuição.
#' @return Estatística e p-valor do teste de Anderson-Darling.
#' @export
ad_test <- function(x, parameters) {
  ad <- goftest::ad.test(x, null = prob_function, parameters, estimated = TRUE)

  res <- c(statistic = unname(ad$statistic), p.value = ad$p.value)

  structure(
    res,
    class = "gof_test",
    dist = attr(parameters, "dist"),
    method = attr(parameters, "method"),
    test = "ad"
  )
}

#' Teste de Qui-quadrado
#'
#' @param x vetor numérico
#' @param parameters parâmetros da distribuição.
#' @param formula fórmula de plotagem.
#' @return Estatística e p-valor do teste de Qui-quadrado.
#' @export
chi_square_test <- function(x, parameters, formula = "weibull") {
  cs <- chisq.test(plotting_position(x, formula), prob_function(x, par))

  res <- c(statistic = unname(cs$statistic), p.value = cs$p.value)

  structure(
    res,
    class = "gof_test",
    dist = attr(parameters, "dist"),
    method = attr(parameters, "method"),
    test = "chi_square"
  )

  # fazer algo sobre os warnings
}

#' Teste de Kolmogorov–Smirnov
#'
#' @param x vetor numérico
#' @param parameters parâmetros da distribuição.
#' @param formula fórmula de plotagem.
#' @return Estatística e p-valor do teste de Kolmogorov–Smirnov.
#' @export
ks_test <- function(x, parameters, formula = "weibull") {
  ks <- ks.test(plotting_position(x, formula), prob_function(x, par))
  res <- c(statistic = unname(ks$statistic), p.value = ks$p.value)

  structure(
    res,
    class = "gof_test",
    dist = attr(parameters, "dist"),
    method = attr(parameters, "method"),
    test = "ks"
  )
}

#' Teste de Filliben
#'
#' @param x vetor numérico
#' @param parameters parâmetros da distribuição.
#' @return Estatística e p-valor do teste de Filliben.
#' @export
filliben_test <- function(x, parameters, formula = "weibull") {

  dist <- attr(parameters, "dist")

  qfn <- .fix_dist_name_ppcc(dist)

  ppos <- .fix_ppos_ppcc(formula)

  if (is.null(qfn))
    stop(sprintf("Not available for distribution: %s", crayon::red(dist)))

  if ("qfn" == "qglogis")
    shape <- 0
  else
    shape <- NULL

  filliben <- ppcc::ppccTest(as.numeric(x), qfn = qfn, shape = shape, ppos = ppos)

  assign("filliben", filliben, envir = .GlobalEnv)

  res <- c(statistic = unname(filliben$statistic), p.value = filliben$p.value)

  structure(
    res,
    class = "gof_test",
    dist = attr(parameters, "dist"),
    method = attr(parameters, "method"),
    test = "filliben"
  )
}


#' print method
#' @method print gof_test
#' @param x S3 object of class gof_test
#' @export
print.gof_test <- function(x, ...) {
  test <- attr(x, "test")
  method <- attr(x, "method")
  dist <- attr(x, "dist")

  test_name <- switch(test,
    "ad" = "Anderson-Darling",
    "ks" = "Kolmogorov–Smirnov",
    "chi_square" = "Qui-quadrado",
    "filliben" = "Filliben"
  )

  s1 <- sprintf("Teste de aderência: %s\n", test_name)
  cat(s1)
  cat(sprintf("Distribuição %s\n", crayon::yellow(.DIST_LIST[dist])))
  cat(sprintf("Estimador de parâmetros: %s\n", crayon::yellow(.METHOD_LIST[method])))
  cat(paste0(rep("-", nchar(s1)-1), collapse = ""), "\n")
  for (n in names(x))
    cat(sprintf("%s = %.4f\n", n, unname(x[n])))
}


# testes
# reprex::reprex({
#   library(wsDist)
#   (x <- rnorm(10))
#   (par <- fit(x, "nor", "mm"))
#   density_function(x, par)
#   (p <- prob_function(x, par))
#   q_function(p, par)
#   plotting_position(x, formula = "blom")
#   ad_test(x, par)
#   chi_square_test(x, par)
#   filliben_test(x, par)
# })

