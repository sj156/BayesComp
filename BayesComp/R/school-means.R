school_means_center <- function(tau, y, s2, m0, v0) {
  stopifnot(
    is.numeric(tau), is.null(dim(tau)), length(tau) > 0L,
    all(is.finite(tau) & tau >= 0),
    is.numeric(y), is.null(dim(y)), length(y) > 0L, all(is.finite(y)),
    is.numeric(s2), is.null(dim(s2)), length(s2) == length(y),
    all(is.finite(s2) & s2 > 0),
    is.numeric(m0), length(m0) == 1L, is.finite(m0),
    is.numeric(v0), length(v0) == 1L, is.finite(v0), v0 > 0
  )

  v_total <- outer(tau^2, s2, "+")
  precision <- 1 / v_total
  v <- 1 / (1 / v0 + rowSums(precision))
  m <- v * (m0 / v0 + drop(precision %*% y))
  list(v_total = v_total, v = v, m = m)
}

school_means_conditional <- function(tau, y, s2, m0, v0) {
  center <- school_means_center(tau, y, s2, m0, v0)
  w <- tau^2 / center$v_total
  m_school <- sweep(w, 2, y, "*") + (1 - w) * center$m
  d <- sweep(w, 2, s2, "*")

  list(
    v = center$v, m = center$m, w = w, m_school = m_school, d = d,
    var = d + (1 - w)^2 * center$v
  )
}

school_means_log_likelihood <- function(tau, y, s2, m0, v0) {
  center <- school_means_center(tau, y, s2, m0, v0)
  residual <- outer(center$m, y, "-")
  quadratic <- rowSums(residual^2 / center$v_total) +
    (center$m - m0)^2 / v0
  log_det <- rowSums(log(center$v_total)) + log(v0) - log(center$v)

  -0.5 * (length(y) * log(2 * pi) + log_det + quadratic)
}

school_means_grid <- function(y, s2, m0, v0, log_prior, upper = 120,
                              n_grid = 24001L) {
  stopifnot(
    is.function(log_prior),
    is.numeric(upper), length(upper) == 1L, is.finite(upper), upper > 0,
    is.numeric(n_grid), length(n_grid) == 1L, is.finite(n_grid),
    n_grid >= 3, n_grid == floor(n_grid)
  )

  tau <- seq(0, upper, length.out = n_grid)
  log_likelihood <- school_means_log_likelihood(tau, y, s2, m0, v0)
  log_prior_values <- log_prior(tau)
  if (!is.numeric(log_prior_values) || !is.null(dim(log_prior_values)) ||
      length(log_prior_values) != n_grid || anyNA(log_prior_values) ||
      any(log_prior_values == Inf)) {
    stop("log_prior must return one finite value or -Inf per grid point.")
  }
  log_posterior <- log_prior_values + log_likelihood
  log_shift <- max(log_posterior)
  if (!is.finite(log_shift)) {
    stop("The posterior has no finite density on the grid.")
  }

  density <- exp(log_posterior - log_shift)
  weights <- density
  weights[c(1L, n_grid)] <- weights[c(1L, n_grid)] / 2
  cumulative <- c(0, cumsum((density[-1L] + density[-n_grid]) / 2))

  list(
    tau = tau,
    weights = weights / sum(weights),
    cdf = cumulative / cumulative[length(cumulative)],
    conditional = school_means_conditional(tau, y, s2, m0, v0),
    log_shift = log_shift
  )
}
