#' Teste de Anderson-Darling
#'
#' @param x vetor numérico
#' @param parameters parâmetros da distribuição.
#' @return Estatística e p-valor do teste de Anderson-Darling.
#' @export
ad_test <- function(x, parameters) {
  p <- prob_function(x, parameters)

  dist <- attr(parameters, "dist")

  p1 <- sort(p)
  p2 <- 1 - sort(p, decreasing = TRUE)

  df <- data.frame(p1 = p1, p2 = p2)

  df$p1[df$p1 == 0] <- 10e-5
  df$p2[df$p2 == 0] <- 10e-5


  N <- length(df$p1)
  s <- (2 * 1:N - 1) * (log(df$p1) + log(df$p2))

  ad_2 <- -N - sum(s)/N

  # correção e valores críticos
  if (dist %in% c("nor", "ln3")) {
    corr <- 1 + .75/N + 2.25/(N**2)
    conf <- c("0.1" = .631, "0.05" = .752, "0.025" = .873, "0.01" = 1.035)
  } else if (dist %in% c("wei", "gum", "gev", "kap", "wak")) {
    corr <- 1 + .2/(N**.5)
    conf <- c("0.1" = .637, "0.05" = .757, "0.025" = .877, "0.01" = 1.038)
  }

  res <- c(statistic = ad_2 * corr, p.value = unname(conf["0.05"]))

  structure(
    res,
    class = c("gof_test", "numeric"),
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

  suppressWarnings({
    cs <- chisq.test(plotting_position(x, formula), prob_function(x, parameters))
  })


  res <- c(statistic = unname(cs$statistic), p.value = cs$p.value)

  structure(
    res,
    class = c("gof_test", "numeric"),
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
  ks <- ks.test(plotting_position(x, formula), prob_function(x, parameters))
  res <- c(statistic = unname(ks$statistic), p.value = ks$p.value)

  structure(
    res,
    class = c("gof_test", "numeric"),
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

  shape <- switch(qfn,
    "qglogis" = parameters["k"],
    "qgev" = parameters["k"],
    "qpearson3" = parameters["gamma"],
    "qweibull" = parameters["delta"],
    NULL
  )

  filliben <- ppcc::ppccTest(as.numeric(x), qfn = qfn, shape = shape, ppos = ppos)

  res <- c(statistic = unname(filliben$statistic), p.value = filliben$p.value)

  structure(
    res,
    class = c("gof_test", "numeric"),
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

