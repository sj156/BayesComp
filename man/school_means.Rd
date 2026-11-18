\name{school_means}
\alias{school_means}
\title{Constructed School-Means Data}
\description{
Teaching data for the hierarchical Gaussian model in Section 3.3 of the
STA5001 lecture notes. The six schools are constructed examples.
}
\usage{data(school_means)}
\format{
A data frame with six rows and three columns.
\describe{
  \item{\code{school}}{School identifier, A through F.}
  \item{\code{observed_mean}}{Sample mean score.}
  \item{\code{n}}{Number of students sampled.}
}
}
\details{With the chapter's known within-school variance of 100, the
sampling variance of each mean is \code{100 / n}.}
\keyword{datasets}
