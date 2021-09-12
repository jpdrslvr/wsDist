require(lmom)

#' Ajusta os parâmetros de uma distribuição de probabilidade
#'
#' @param x vetor numérico.
#' @eval .params_dist()
#' @eval .params_method()
#' @return Parâmetros ajustados.
#' @examples
#' fit(rnorm(50), "nor", "mm")
#' @export
fit <- function(x, dist, method = "mml") {
  dist <- match.arg(dist, names(.DIST_LIST))
  method <- match.arg(method, names(.METHOD_LIST))

  par_fun <- tryCatch(
    get(sprintf(".%s_parameters_%s", dist, method)),
    error = function(e) {
      stop(sprintf("%s distribution not available for method %s",
                   crayon::red(dist), crayon::red(method)),
           call. = FALSE)
    }
  )

  par_fun(x)
}

# construtor da classe parameters
.par_class <- function(par, dist, method) {
  structure(
    unname(par),
    class = c("parameters", dist, "numeric"),
    method = method,
    dist = dist,
    names = .get_parameters_names(dist)
  )
}

#' print method
#' @method print parameters
#' @param x S3 object of class parameters.
#' @export
print.parameters <- function(x, ...) {
  method <- attr(x, "method")
  dist <- class(x)[2]

  s1 <- sprintf("Distribuição %s\n", crayon::yellow(.DIST_LIST[dist]))
  cat(s1)
  cat(sprintf("Estimador de parâmetros: %s\n", crayon::yellow(.METHOD_LIST[method])))
  cat(paste0(rep("-", nchar(s1)-11), collapse = ""), "\n")
  for (n in names(x))
    cat(sprintf("%s = %.4f\n", n, unname(x[n])))
}


# MÉTODO DOS MOMENTOS (MM)
# distribuição gumbel para mínimos - livro mello
.gum_min_parameters_mm <- function(x) {
  alpha <- 1.2826 / sd(x)
  xi <- mean(x) + (0.45 * sd(x))
  par <- c(xi = xi, alpha = alpha)
  .par_class(par, dist = "gum_min", method = "mm")
}

# distribuição gumbel para máximos - livro mello
.gum_max_parameters_mm <- function(x) {
  alpha <- 1.2826 / sd(x)
  xi <- mean(x) - (0.45 * sd(x))
  par <- c(xi = xi, alpha = alpha)
  .par_class(par, dist = "gum_max", method = "mm")
}

# distribuição normal
.nor_parameters_mm <- function(x) {
  par <- c(mu = mean(x), sigma = sd(x))
  .par_class(par, dist = "nor", method = "mm")
}

# distribuição ln3 - livro mello
.ln3_parameters_mm <- function(x) {
  avg <- mean(x)
  stdev <- sd(x)
  gamma <- EnvStats::skewness(x, method = "fisher")
  phi <- (-gamma + (gamma**2 + 4)**0.5)/2
  ny <- (1 - phi**(2/3))/(phi**(1/3))
  beta <- avg - (stdev/ny)

  # parameters
  mi <- log(stdev/ny) - 0.5 * log(1 + ny**2)
  sigma <- (log(1 + ny**2))**0.5

  par <- c(beta, mi, sigma)
  .par_class(par, dist = "ln3", method = "mm")
}

# distribuilção exponencial
# .exp_parameters_mm <- function(x) {
#   par <- fitdistrplus::fitdist(x, "exp", method = "mme")$estimate
#   .par_class(par, dist = "exp", method = "mm")
# }

# distribuição gev - livro mello / marcelle
.gev_parameters_mm <- function(x) {
  x_mean <- mean(x)
  x_var  <- var(x)
  E_x    <- EnvStats::skewness(x, method="fisher")

  # setando um valor inicial para epsilon por meio do Método dos Momentos-L
  MML <- lmom::samlmu(x=x, nmom=4)

  GEV_par_MML <- lmom::pelgev(MML)
  epsilon_ini <- as.numeric(abs(GEV_par_MML[3]))

  f = function(epsilon) {
    f_est <- ((-(exp(lgamma(1+3*epsilon)) )+3*(exp(lgamma(1+epsilon)))*(exp(lgamma(1+2*epsilon)))-2*(exp(lgamma(1+epsilon)))^3)/((exp(lgamma(1+2*epsilon)))-(exp(lgamma(1+epsilon)))^2)^(3/2))
    Metrics::rmse(E_x, f_est)
  }

  # ------------------
  # otimização de epsilon
  result <- SCEoptim(f, epsilon_ini, lower = 0.001, upper = 1.0)

  # parâmetros da GEV: Método dos Momentos
  epsilon <- result[["par"]]
  sigma   <- ((x_var/((exp(lgamma(1+2*epsilon)))-(exp(lgamma(1+epsilon)))^2))^0.5)*epsilon
  mu      <- x_mean-(sigma/epsilon)*(1-(exp(lgamma(1+epsilon))))

  par <- c(epsilon, sigma, mu)
  .par_class(par, dist = "gev", method = "mm")
}

# distribuição gamma - livro mello / marcelle
.gam_parameters_mm <- function(x) {
  par <- ExtDist::eGamma(x, method = "moments")
  .par_class(par, dist = "gam", method = "mm")
}

#distribuição weibull
.wei_parameters_mm <- function(x) {
  par <- ExtDist::eWeibull(x, method = "moments")
  .par_class(par, dist = "wei", method = "mm")
}


# MÉTODO DA MÁXIMA VEROSSIMILHANÇA

# distribuição exponencial
# .exp_parameters_ml <- function(x) {
#   par <- univariateML::mlexp(x)
#   .par_class(par, dist = "exp", method = "ml")
# }

# distribuição logistica generalizada
.glo_parameters_ml <- function(x) {
  par <- glogis::glogisfit(x)$parameters
  .par_class(par, dist = "glo", method = "ml")
}

# distribuição gev
.gev_parameters_ml <- function(x) {
  par <- quiet(ismev::gev.fit(x)$mle)
  .par_class(par, dist = "gev", method = "ml")
}

# distribuição gev
.gum_max_parameters_ml <- function(x) {
  par <- univariateML::mlgumbel(x)
  .par_class(c(par[1], par[2]), dist = "gum_max", method = "ml")
}

# distribuição normal
.nor_parameters_ml <- function(x) {
  par <- univariateML::mlnorm(x)
  .par_class(c(par[1], par[2]), dist = "nor", method = "ml")
}

# distribuição gamma
.gam_parameters_ml <- function(x) {
  par <- ExtDist::eGamma(x, method = "numerical.MLE")
  .par_class(par, dist = "gam", method = "ml")
}

# distribuição weibull
.wei_parameters_ml <- function(x) {
  par <- ExtDist::eWeibull(x, method = "numerical.MLE")
  .par_class(par, dist = "wei", method = "ml")
}

.ln3_parameters_ml <- function(x) {
  # setando um valor inicial para a por meio do Método dos Momentos-L (a = zeta)
  MML <- lmom::samlmu(x=x,nmom=4)

  LN3_par_MML <- lmom::pelln3(MML)
  a           <- as.numeric(abs(LN3_par_MML[1]))

  xi <- (x-a)

  n     <- length(x)
  mi    <- mean(log(xi))
  sigma <- (sqrt(mean(log((xi-mi)^2))))

  # função de otimização
  f <- function(a) {
    f_est <- -(-n*log(sqrt(mean(log(((x-a)-mi)^2))))-((n*log(2*pi))/2)-(sum(log(x-a)))-(1/(2*((sqrt(mean(log(((x-a)-mi)^2))))^2)))*(sum(log(((x-a)-mi)^2))))
  }

  # otimização de a mara maximização de LN(L) = f_est (função fest tem negativo na frente para maximização)
  # restrição de a
  a_rest <- min(x)-0.02
  result <- SCEoptim(f, a, lower = 0.01, upper = a_rest)

  a_est <- result[["par"]]

  # parâmetros finais
  a_est <- result[["par"]]
  mi    <- mean(log(xi))
  sigma <- (sqrt(mean(log((xi-mi)^2))))

  par <- c(zeta = a_est, mu = mi, sigma = sigma)
  .par_class(par, dist = "ln3", method = "ml")
}


# MÉTODO DOS MOMENTOS L

# distribuição gumbel para mínimos - livro mello
.gum_min_parameters_mml <- function(x) {
  l_mom <- unname(lmom::samlmu(x))
  alpha <- log(2) / l_mom[2]
  xi <- l_mom[1] + (0.5772/alpha)
  par <- c(xi = xi, alpha = alpha)
  .par_class(par, dist = "gum_min", method = "mml")
}

# função que retorna a função de ajuste dos parâmetros
# pelo método dos momentos-L - pacote lmom
.lmom_par <- function(dist) {
  pel_fun <- get(paste0("pel", dist), as.environment("package:lmom"))
  dist_name <- ifelse(dist == "gum", "gum_max", dist)
  function(x) {
    par <- pel_fun(lmom::samlmu(x, nmom = 5))
    .par_class(par, dist = dist_name, method = "mml")
  }
}

for (.dist in names(.DIST_LIST)) {
  if (.dist != "gum_min") {
    .dist_name <- ifelse(.dist == "gum_max", "gum", .dist)
    assign(sprintf(".%s_parameters_mml", .dist), .lmom_par(.dist_name))
  }
}

# library(lmom)
# # lmom
# l <- lmom::samlmu(x) |> unname()
# p_max <- pelgum(l)
# # livro
#
# alpha <- log(2)/l[2]
# xi <- l[1] + 0.5772/alpha
# p_min <- c(xi = xi, alpha = alpha)
