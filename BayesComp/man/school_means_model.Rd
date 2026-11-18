\name{school_means_model}
\alias{school_means_conditional}
\alias{school_means_grid}
\alias{school_means_log_likelihood}
\title{Hierarchical Gaussian School-Means Calculations}
\description{
Evaluate the conditional Gaussian posterior, integrate out the Gaussian
parameters, and approximate the marginal posterior of the between-school
standard deviation by trapezoidal quadrature.
}
\usage{
school_means_conditional(tau, y, s2, m0, v0)
school_means_log_likelihood(tau, y, s2, m0, v0)
school_means_grid(y, s2, m0, v0, log_prior, upper = 120, n_grid = 24001L)
}
\arguments{
  \item{tau}{Nonnegative, finite between-school standard deviations.}
  \item{y}{Finite observed school means.}
  \item{s2}{Positive sampling variances of the observed means, in school order.}
  \item{m0, v0}{Prior mean and positive prior variance of the shared center.}
  \item{log_prior}{Vectorized log prior density evaluated on the standard
  deviation scale, up to an additive constant. Return \code{-Inf} at any
  grid point outside the prior support.}
  \item{upper}{Positive upper endpoint of the integration grid.}
  \item{n_grid}{Number of grid points including both endpoints, at least three.}
}
\details{
Given the latent school mean, the observed mean has Gaussian sampling
variance \code{s2}. Conditional on the shared center and \code{tau},
latent school means are independent Gaussian with variance \code{tau^2}.
The shared center has a Gaussian prior with mean \code{m0} and variance
\code{v0}. Choose grid spacing and upper endpoint for the data and prior in
use. The approximation normalizes over \code{[0, upper]}.
}
\value{
\code{school_means_conditional()} returns a list. The vectors \code{m} and
\code{v} are the posterior mean and variance of the shared center at each
\code{tau}. Matrices have one row per scale and one column per school.
\code{w} is the weight on the observed mean, and \code{d} is the school
posterior variance given the center and scale. \code{m_school} and \code{var}
are the school posterior mean and variance after integrating out the center.

\code{school_means_log_likelihood()} returns one log marginal density of
the observed means per scale, with the shared center and latent school
means integrated out.

\code{school_means_grid()} returns grid points \code{tau}, normalized
trapezoidal weights \code{weights}, the cumulative trapezoidal integral
\code{cdf}, conditional quantities \code{conditional}, and the
\code{log_shift} subtracted from the log posterior kernel before
exponentiating.
}
\seealso{\code{\link{school_means}}}
\examples{
data(school_means)
y <- school_means$observed_mean
s2 <- 100 / school_means$n
school_means_conditional(c(0, 8), y, s2, m0 = 70, v0 = 100)

log_prior <- function(tau) log(2) + dnorm(tau, sd = 10, log = TRUE)
grid <- school_means_grid(y, s2, 70, 100, log_prior)
colSums(grid$conditional$m_school * grid$weights)
}
