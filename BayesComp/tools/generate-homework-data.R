# Run from the repository root.
data_dir <- "BayesComp/data"
if (!dir.exists(data_dir) || !file.exists("BayesComp/DESCRIPTION")) {
  stop("Run this script from the BayesComp repository root.", call. = FALSE)
}

RNGkind("Mersenne-Twister", "Inversion", "Rejection")
write_data <- function(rows, name) {
  write.table(rows, file.path(data_dir, paste0(name, ".csv")),
              sep = ";", row.names = FALSE, quote = FALSE)
}

set.seed(50101)
admissions <- data.frame(
  group = rep(c("A", "B"), each = 2L),
  department = rep(c("X", "Y"), times = 2L),
  applicants = c(200L, 40L, 40L, 200L)
)
admissions$admitted <- rbinom(nrow(admissions), admissions$applicants,
                              c(.43, .82, .33, .73))
write_data(admissions, "hw01_admissions")

set.seed(50102)
hours <- c(.5, 2, 1, 3.5, 1.5, 4, 2.5, .5, 3, 2, 1, 4, 3.5, 1.5, 3, 2.5)
incidents <- data.frame(
  window = seq_along(hours),
  exposure_hours = hours,
  incidents = rpois(length(hours), lambda = 1.15 * hours)
)
write_data(incidents, "hw02_incidents")

set.seed(50103)
se <- c(1.5, .6, .3, 1.1, .4, 1.7, .7)
lab_offset <- rnorm(length(se), mean = 1.5, sd = 1.6)
labs <- data.frame(
  lab = LETTERS[seq_along(se)],
  offset_mv = round(rnorm(length(se), mean = lab_offset, sd = se), 2),
  se_mv = se
)
write_data(labs, "hw03_labs")

set.seed(50104)
speed <- rep(seq(10, 30, by = 5), each = 8L)
z <- (speed - 20) / 10
braking <- data.frame(
  run = seq_along(speed),
  speed_mph = speed,
  distance_ft = round(rnorm(length(speed), mean = 55 + 31 * z + 9 * z^2,
                            sd = 9), 1)
)
write_data(braking, "hw04_braking")

set.seed(50105)
n <- 24L
flow <- rnorm(n)
temperature <- .65 * flow + sqrt(1 - .65^2) * rnorm(n)
loss <- data.frame(
  run = seq_len(n),
  flow_index = round(flow, 3),
  temperature_index = round(temperature, 3),
  loss = round(rnorm(n, mean = 12 + 1.8 * flow + .7 * temperature, sd = 2), 3)
)
write_data(loss, "hw05_process_loss")

set.seed(50106)
n <- 12L
latency <- data.frame(
  batch = seq_len(n),
  difference_ms = round(rnorm(n, mean = 75, sd = 180))
)
write_data(latency, "hw06_latency")
