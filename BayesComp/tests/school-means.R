library(BayesComp)
data(school_means)

y <- school_means$observed_mean
s2 <- 100 / school_means$n
m0 <- 70
v0 <- 100

# Direct multivariate Gaussian calculations, independent of the package's
# scalar completion of the square.
reference <- function(tau) {
  prior_cov <- diag(tau^2, length(y)) + v0
  marginal_cov <- prior_cov + diag(s2)
  chol_cov <- chol(marginal_cov)
  centered <- y - m0
  log_density <- -length(y) / 2 * log(2 * pi) -
    sum(log(diag(chol_cov))) -
    sum(backsolve(chol_cov, centered, transpose = TRUE)^2) / 2
  adjusted <- prior_cov %*% solve(marginal_cov)
  list(
    log_density = log_density,
    mean = drop(m0 + adjusted %*% centered),
    var = diag(prior_cov - adjusted %*% prior_cov)
  )
}

tau <- c(0, 2, 8, 50)
expected <- lapply(tau, reference)
conditional <- school_means_conditional(tau, y, s2, m0, v0)
stopifnot(
  isTRUE(all.equal(
    school_means_log_likelihood(tau, y, s2, m0, v0),
    vapply(expected, function(x) x$log_density, numeric(1))
  )),
  isTRUE(all.equal(conditional$m_school, do.call(rbind, lapply(expected, "[[", "mean")))),
  isTRUE(all.equal(conditional$var, do.call(rbind, lapply(expected, "[[", "var"))))
)

# Compare the grid mean against adaptive integration of the full Gaussian
# log likelihood and a gamma prior on reciprocal variance.
log_prior <- function(tau) {
  out <- rep(-Inf, length(tau))
  t <- tau[tau > 0]
  out[tau > 0] <- dgamma(1 / t^2, shape = 3, rate = 200, log = TRUE) +
    log(2) - 3 * log(t)
  out
}
grid <- school_means_grid(y, s2, m0, v0, log_prior)
kernel <- function(tau) {
  lp <- vapply(tau, function(t) reference(t)$log_density, numeric(1))
  exp(lp + log_prior(tau) - grid$log_shift)
}
tau_mean <- integrate(function(t) t * kernel(t), 0, Inf, rel.tol = 1e-9)$value /
  integrate(kernel, 0, Inf, rel.tol = 1e-9)$value
stopifnot(
  abs(sum(grid$weights) - 1) < 1e-12,
  grid$cdf[1] == 0,
  tail(grid$cdf, 1) == 1,
  all(diff(grid$cdf) >= 0),
  abs(sum(grid$tau * grid$weights) - tau_mean) < 1e-8
)
