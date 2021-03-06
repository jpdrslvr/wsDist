% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parameters.R
\name{fit}
\alias{fit}
\title{Ajusta os parâmetros de uma distribuição de probabilidade}
\usage{
fit(x, dist, method = "mml")
}
\arguments{
\item{x}{vetor numérico.}

\item{dist}{distribuição de probabilidade.
\itemize{
    \item "gam" (Gamma)
    \item "gev" (GEV)
    \item "glo" (Logística generalizada)
    \item "gno" (Normal generalizada)
    \item "gpa" (Pareto generalizada)
    \item "gum_min" (Gumbel para mínimos)
    \item "gum_max" (Gumbel para máximos)
    \item "kap" (Kappa)
    \item "ln3" (Log-normal 3 parâmetros)
    \item "nor" (Normal)
    \item "pe3" (Pearson tipo 3)
    \item "wak" (Wakeby)
    \item "wei" (Weibull)
}}

\item{method}{Método de ajuste.
\itemize{
    \item "mm" (Momentos)
    \item "mml" (Momentos-L)
    \item "ml" (Máxima Verossimilhança)
}}
}
\value{
Parâmetros ajustados.
}
\description{
Ajusta os parâmetros de uma distribuição de probabilidade
}
\examples{
fit(rnorm(50), "nor", "mm")
}
