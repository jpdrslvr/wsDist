# ad_test <- function(x, dist, par, alpha = 0.05) {
#
#   f <- get(paste0("cdf", dist), envir = as.environment("package:lmom"))
#
#   p <- f(x, par)
#
#   p1 <- sort(p)
#   p2 <- 1 - sort(p, decreasing = TRUE)
#
#   df <- data.frame(p1 = p1, p2 = p2)
#
#   df$p1[df$p1 == 0] <- 10e-5
#   df$p2[df$p2 == 0] <- 10e-5
#
#
#   N <- length(df$p1)
#   s <- (2 * 1:N - 1) * (log(df$p1) + log(df$p2))
#
#   ad_2 <- -N - sum(s)/N
#
#   # correção e valores críticos
#   if (dist %in% c("nor", "ln3")) {
#     corr <- 1 + .75/N + 2.25/(N**2)
#     conf <- c("0.1" = .631, "0.05" = .752, "0.025" = .873, "0.01" = 1.035)
#   } else if (dist %in% c("wei", "gum", "gev", "kap", "wak")) {
#     corr <- 1 + .2/(N**.5)
#     conf <- c("0.1" = .637, "0.05" = .757, "0.025" = .877, "0.01" = 1.038)
#   }
#
#   statistic <- ad_2 * corr
#   H0 <- conf[as.character(alpha)] > statistic
#
#   list(statistic = statistic, H0 = unname(H0))
#
# }


# ad_test2 <- function(x, dist, par, alpha = 0.05) {
#
#   f <- get(paste0("cdf", dist), envir = as.environment("package:lmom"))
#
#   p <- f(x, par)
#
#   p1 <- sort(p)
#   p2 <- 1 - sort(p, decreasing = TRUE)
#
#   df <- data.frame(p1 = p1, p2 = p2)
#   df <- df[rowSums(df != 0) == length(df), ]
#
#
#   # df$p1[df$p1 == 0] <- 10e-5
#   # df$p2[df$p2 == 0] <- 10e-5
#
#   # print(head(df))
#
#   N <- length(df$p1)
#   s <- (2 * 1:N - 1) * (log(df$p1) + log(df$p2))
#
#   ad_2 <- -N - sum(s)/N
#
#   # correção e valores críticos
#   if (dist %in% c("nor", "ln3")) {
#     corr <- 1 + .75/N + 2.25/(N**2)
#     conf <- c("0.1" = .631, "0.05" = .752, "0.025" = .873, "0.01" = 1.035)
#   } else if (dist %in% c("wei", "gum", "gev", "kap", "wak")) {
#     corr <- 1 + .2/(N**.5)
#     conf <- c("0.1" = .637, "0.05" = .757, "0.025" = .877, "0.01" = 1.038)
#   }
#   # else {
#   #   corr <- ?
#   #   conf <- ?
#   # }
#
#   statistic <- ad_2 * corr
#   H0 <- conf[as.character(alpha)] > statistic
#
#   list(statistic = statistic, H0 = unname(H0))
#
# }

# library(lmom)
# library(magrittr)
#
# dados <- read.csv2("/home/syhda/Desktop/series_at_site_ffa.csv")
#
# cols <- names(dados) %>% grep(pattern = "st_", x = ., value = TRUE)
#
# x <- dados$st_12700000
#
# x <- x[!is.na(x)]
# par <- pelwak(samlmu(x, 5))
#
# # substituindo 0 por 10e-5
# ad_test(x, dist = "wak", par = par)
# # removendo 0s
# ad_test2(x, dist = "wak", par = par)
#
#
# ad <- apply(dados[, cols], 2, function(x) {
#   x <- x[!is.na(x)]
#   par <- pelwak(samlmu(x, 5))
#   ad_test(x, dist = "wak", par = par)
# }) %>% do.call(cbind, args = .) %>% t()
#
#
# ad2 <- apply(dados[, cols], 2, function(x) {
#   x <- x[!is.na(x)]
#   par <- pelwak(samlmu(x, 5))
#   ad_test2(x, dist = "wak", par = par)
# }) %>% do.call(cbind, args = .) %>% t()
#
