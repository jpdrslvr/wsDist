
.weibull <- function(x) 1:length(x) / (length(x) + 1)
.gringorten <- function(x) (1:length(x) - 0.44) / (length(x) + 0.12)
.blom <- function(x) (1:length(x) - 0.375) / (length(x) + 0.25)
.hazem <- function(x) (1:length(x) - 0.5) / length(x)
.cunnane <- function(x) (1:length(x) - 0.4) / (length(x) + 0.2)


#' Posição de plotagem
#'
#' @param x vetor numérico.
#' @param exced logical; probabilidade de excedência.
#' @param formula weibull, gringorten, blom, hazem ou cunnane.
#' @return posições de plotagem para a fórmula selecionada.
#' @examples
#' x <- rnorm(50)
#' plotting_position(x, formula = "weibull")
#' @export
plotting_position <- function(x, exced = FALSE, formula = "weibull") {
  formula <- match.arg(formula, c("weibull", "gringorten", "blom", "hazem", "cunnane"))

  plt_pos_fun <- get(paste0(".", formula))

  if (exced)
    p <- 1 - plt_pos_fun(x)
  else
    p <- plt_pos_fun(x)

  structure(p, class = "plotting_position", formula = formula)
}

#' print method
#' @method print plotting_position
#' @param x S3 object of class q_function.
#' @export
print.plotting_position <- function(x, ...) {
  formula <- attr(x, "formula")

  s1 <- sprintf("Posição de plotagem\n")
  s2 <- sprintf("Fórmula: %s\n", crayon::yellow(formula))
  cat(s1, s2, sep = "")
  cat(paste0(rep("-", max(nchar(s1), nchar(s2) - 11) - 1), collapse = ""), "\n")
  print(as.numeric(x))
}
