\name{homework_data}
\alias{hw01_admissions}
\alias{hw02_incidents}
\alias{hw03_labs}
\alias{hw04_braking}
\alias{hw05_process_loss}
\alias{hw06_latency}
\title{Synthetic Data for the STA5001 Homework Assignments}
\description{
Fixed simulated datasets for the homework assignments in Sections 1--6 of the
BayesComp computational companion.
}
\usage{
data(hw01_admissions)
data(hw02_incidents)
data(hw03_labs)
data(hw04_braking)
data(hw05_process_loss)
data(hw06_latency)
}
\format{
Six data frames. Each row is one observation or one set of sufficient
statistics.
\describe{
  \item{\code{hw01_admissions}}{Four group-by-department cells. Columns are
    \code{group}, \code{department}, \code{applicants}, and \code{admitted}.}
  \item{\code{hw02_incidents}}{Sixteen monitoring windows, with columns
    \code{window}, \code{exposure_hours}, and \code{incidents}.}
  \item{\code{hw03_labs}}{Seven laboratory summaries, with columns
    \code{lab}, \code{offset_mv} (estimated offset in millivolts), and
    \code{se_mv} (its standard error in millivolts).}
  \item{\code{hw04_braking}}{Forty bench runs, with columns \code{run},
    \code{speed_mph}, and \code{distance_ft}.}
  \item{\code{hw05_process_loss}}{Twenty-four experimental runs, with columns
    \code{run}, \code{flow_index}, \code{temperature_index}, and \code{loss}.
    The indices and loss are on dimensionless teaching scales.}
  \item{\code{hw06_latency}}{Twelve paired timing batches, with columns
    \code{batch} and \code{difference_ms} (latency with the check minus
    latency without it, in milliseconds).}
}
}
\source{Generated for STA5001 by \file{BayesComp/tools/generate-homework-data.R}
in the companion repository. The generator specifies the seeds and
data-generating models.}
\keyword{datasets}
